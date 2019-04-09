//
//  LoginViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

enum Status {
    case login
    case logout
    
    func btnTitle() -> String {
        switch self {
        case .login:
            return "Login"
        case .logout:
            return "Logout"
        }
    }
    
    func btnAction(vc: LoginViewController) {
        switch self {
        case .login:
            vc.loginAction()
        case .logout:
            vc.logoutAction()
        }
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var status: Status = .login
    
    var viewModel: LoginViewModel!
    let userApiManager: UserAPIManager = UserAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(userInfo: UserInfoService(), keychainService: KeychainSecretStore())
        setPreviousInfo()
        loginButton.setTitle(status.btnTitle(), for: .normal)
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        if isEmptyInput() {
            SVProgressHUD.showError(withStatus: "User name and password can not be empty")
            return
        }
        status.btnAction(vc: self)
    }
    
    private func setPreviousInfo() {
        guard let info = viewModel.getUserInfo() else {
            return
        }
        
        userNameTextField.text = info.name
        avatarImageView.kf.setImage(with: URL(string: info.avatarUrl),
                                    placeholder: UIImage.profileImage(),
                                    options: [.transition(.fade(1))])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func isEmptyInput() -> Bool {
        return viewModel.isUserNameOrPasswordEmpty(userName: userNameTextField.text!, password: passwordTextField.text!)
    }
    
    func loginAction() {
        SVProgressHUD.show()
        userApiManager.login(userName: userNameTextField.text!, password: passwordTextField.text!, handler: { [weak self] result in
            switch result {
            case .success(let result):
                self?.getUserInfo(result)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        })
    }
    
    func logoutAction() {
        guard let loginResult = viewModel.getTokenAndId() else {
            SVProgressHUD.showError(withStatus: "Logout Failed")
            return
        }
        
        SVProgressHUD.show()
        userApiManager.logout(userName: userNameTextField.text!, password: passwordTextField.text!, id: loginResult.id, handler: { [weak self] result in
            switch result {
            case .success:
                self?.passwordTextField.text = ""
                self?.viewModel.emptyToken()
                self?.status = .login
                self?.loginButton.setTitle("Login", for: .normal)
                SVProgressHUD.showInfo(withStatus: "Logout Success")
            case .failure:
                SVProgressHUD.showError(withStatus: "Logout Failed")
            }
        })
    }
    
    private func getUserInfo(_ loginResult: (token: String, id: String)) {
        userApiManager.profile(token: loginResult.token) { [weak self] result in
            guard let strongSelf = self else {
                SVProgressHUD.showError(withStatus: "Fatal error")
                return
            }
            
            switch result {
            case .success(let user):
                user.name = strongSelf.userNameTextField.text ?? ""
                if strongSelf.viewModel.saveUserInfoAndLoginResult(user: user, loginResult: loginResult) {
                    SVProgressHUD.dismiss()
                    strongSelf.dismiss(animated: true, completion: nil)
                } else {
                    SVProgressHUD.showError(withStatus: "Get user info failed!")
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
