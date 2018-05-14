//
//  GitHubEventsConfiguration.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

class GitHubEventConfiguration {
  class func configure(viewController: GitHubEventsViewController) {
    let presenter = GitHubEventsPresenter(view: viewController)
    let interactor = GitHubEventsInteractor(
      presenter: presenter,
      client: RxURLSessionClient(),
      localStorage: CoreDataLocalStorage(),
      keychainAccessor: KeychainAccessor()
    )
    viewController.interactor = interactor
  }
}
