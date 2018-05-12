//
//  GitHubLoginViewController.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/10.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit

protocol GitHubLoginView: class {
  func dismiss()
}

class GitHubLoginViewController: UIViewController {
  
  @IBOutlet weak var emailOrUsernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  var interactor: GitHubLoginInteractorProtocol!
  
  func dismiss() {
    view.isHidden = true
  }
  
  @IBAction func didClickLoginButton(sender: UIButton) {
    guard
      let emailOrUsername = emailOrUsernameTextField.text,
      let password = passwordTextField.text,
      !emailOrUsername.isEmpty,
      !password.isEmpty else {
      // TODO: popup a HUD / show error message under text field
      print("Username and password can not be empty!")
      return
    }
    
    interactor.login(withEmailOrUsername: emailOrUsername, password: password)
  }
  
  @IBAction func didClickOAuth2LoginButton(sender: UIButton) {
  }
}

extension GitHubLoginViewController: GitHubLoginView {
  
}
