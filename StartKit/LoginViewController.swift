//
//  LoginViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        if isEmptyInput() {
            SVProgressHUD.showError(withStatus: "User name and password can not be empty")
            return
        }
        SVProgressHUD.show()
        UserAPIManager().login(userName: userNameTextField.text!, password: passwordTextField.text!, handler: { [weak self] result in
            switch result {
            case .success(let token):
                KeychainSecretStore().saveToken(token: token)
                self?.getUserInfo()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        })
    }
    
    private func isEmptyInput() -> Bool {
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            return true
        }
        return false
    }
    
    func getUserInfo() {
        guard let token = KeychainSecretStore().getToken() else { return }
        UserAPIManager().profile(token: token) { [weak self] result in
            switch result {
            case .success(let user):
                if UserInfoService().saveUserInof(user: user) {
                    self?.dismiss(animated: true, completion: nil)
                    SVProgressHUD.dismiss()
                } else {
                    SVProgressHUD.showError(withStatus: "Get user info failed!")
                }
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
