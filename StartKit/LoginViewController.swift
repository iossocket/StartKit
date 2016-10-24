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

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        SVProgressHUD.show()
        UserAPIManager().login(userName: userNameTextField.text!, password: passwordTextField.text!, handler: { result in
            switch result {
            case .success(let token):
                KeychainSecretStore().saveToken(token: token)
                SVProgressHUD.dismiss()
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        })
    }
    
    func getUserInfo() {
        guard let token = KeychainSecretStore().getToken() else { return }
        UserAPIManager().profile(token: token) { result in
            switch result {
            case .success(let user):
                print(user.name)
                print(user.avatarUrl)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
