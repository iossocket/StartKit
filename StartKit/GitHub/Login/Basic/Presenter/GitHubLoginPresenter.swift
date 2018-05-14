//
//  GitHubLoginPresenter.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/11.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

protocol GitHubLoginPresenterProtocol {
  func dismissLoginView()
}

class GitHubLoginPresenter: GitHubLoginPresenterProtocol {
  private let view: GitHubLoginView
  
  init(view: GitHubLoginView) {
    self.view = view
  }
  
  func dismissLoginView() {
    view.dismiss?()
  }
}
