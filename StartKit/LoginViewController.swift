//
//  LoginViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        UserAPIManager().login(userName: userNameTextField.text!, password: passwordTextField.text!, handler: { result in
            switch result {
            case .userToken(let token):
                print(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
