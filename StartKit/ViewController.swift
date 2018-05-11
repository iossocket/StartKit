//
//  ViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let xxx: GitHubLoginInteractorProtocol = GitHubLoginInteractor(client: RxURLSessionClient(), presenter: GitHubLoginPresenter())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO:
    let viewController = UIStoryboard(name: "GitHubLogin", bundle: nil).instantiateViewController(withIdentifier: "GitHubLoginViewController")
    viewController.willMove(toParentViewController: self)
    addChildViewController(viewController)
    view.addSubview(viewController.view)
    viewController.didMove(toParentViewController: self)
  }
}
