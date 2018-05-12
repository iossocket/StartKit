//
//  ViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let viewController = UIStoryboard(name: "GitHubLogin", bundle: nil).instantiateViewController(withIdentifier: "GitHubLoginViewController") as? GitHubLoginViewController else {
      return
    }
    
    GitHubLoginConfiguration.configure(viewController: viewController)
    viewController.willMove(toParentViewController: self)
    addChildViewController(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParentViewController: self)
  }
}
