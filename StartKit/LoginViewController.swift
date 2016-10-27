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

class LoginViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: LoginViewModel!
    let userApiManager: UserAPIManager = UserAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(userInfo: UserInfoService(), keychainService: KeychainSecretStore())
        setPreviousInfo()
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        if isEmptyInput() {
            SVProgressHUD.showError(withStatus: "User name and password can not be empty")
            return
        }
        loginAction()
    }
    
    private func setPreviousInfo() {
        guard let info = viewModel.getUserInfo() else {
            return
        }
        
        userNameTextField.text = info.name
        avatarImageView.kf.setImage(with: URL(string: info.avatarUrl),
                                    placeholder: UIImage.profileImage(),
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil, completionHandler: nil)
    }
    
    private func isEmptyInput() -> Bool {
        return viewModel.isUserNameOrPasswordEmpty(userName: userNameTextField.text!, password: passwordTextField.text!)
    }
    
    private func loginAction() {
        SVProgressHUD.show()
        userApiManager.login(userName: userNameTextField.text!, password: passwordTextField.text!, handler: { [weak self] result in
            switch result {
            case .success(let token):
                self?.getUserInfo(token)
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        })
    }
    
    private func getUserInfo(_ token: String) {
        userApiManager.profile(token: token) { [weak self] result in
            guard let strongSelf = self else {
                SVProgressHUD.showError(withStatus: "Fatal error")
                return
            }
            
            switch result {
            case .success(let user):
                if strongSelf.viewModel.saveUserInfoAndToken(user: user, token: token) {
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
