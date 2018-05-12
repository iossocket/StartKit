//
//  GitHubLoginConfiguration.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/12.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

class GitHubLoginConfiguration {
  class func configure(viewController: GitHubLoginViewController) {
    let presenter = GitHubLoginPresenter(view: viewController)
    var client = RxURLSessionClient()
    // MSG: We have to set request cache policy `reloadIgnoringLocalCacheData` for GitHub API issue,
    // we can see discussion here: https://platform.github.community/t/executing-a-request-again-results-in-412-precondition-failed/1456/3
    client.configure(cachePolicy: .reloadIgnoringLocalCacheData)
    let interactor = GitHubLoginInteractor(client: client, presenter: presenter)
    viewController.interactor = interactor
  }
}
