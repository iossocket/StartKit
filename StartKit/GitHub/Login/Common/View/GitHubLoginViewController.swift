//
//  GitHubLoginViewController.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/10.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit

protocol GitHubLoginView: class {
  
}

class GitHubLoginViewController: UIViewController {
  
  @IBOutlet weak var emailOrUsernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  var interactor: GitHubLoginInteractorProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func didClickLoginButton(sender: UIButton) {
  }
  
  @IBAction func didClickOAuth2LoginButton(sender: UIButton) {
  }
}

extension GitHubLoginViewController: GitHubLoginView {
  
}
