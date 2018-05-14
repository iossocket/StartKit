//
//  ViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showHomeViewController()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !loggedIn() {
      showLoginViewController()
    }
  }
  
  func showLoginViewController() {
    guard let viewController = UIStoryboard(name: "GitHubLogin", bundle: nil).instantiateViewController(withIdentifier: "GitHubLoginViewController") as? GitHubLoginViewController else {
      return
    }
    GitHubLoginConfiguration.configure(viewController: viewController)
    viewController.dismiss = {
      viewController.dismiss(animated: true, completion: nil)
    }
    present(viewController, animated: true, completion: nil)
  }
  
  func showHomeViewController() {
    guard let viewController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() else {
      return
    }
    viewController.willMove(toParentViewController: self)
    addChildViewController(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParentViewController: self)
  }
  
  func loggedIn() -> Bool {
    return KeychainAccessor().currentAccount()?.account != nil && KeychainAccessor().currentAccount()?.password != nil
  }
}
