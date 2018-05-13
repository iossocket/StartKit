//
//  GitHubEventsPresenter.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

protocol GitHubEventsPresenterProtocol {
  func configureEventList(with events: [Event])
}

class GitHubEventsPresenter: GitHubEventsPresenterProtocol {
  let view: GitHubEventsView
  
  init(view: GitHubEventsView) {
    self.view = view
  }
  
  func configureEventList(with events: [Event]) {
    view.configure(with: GitHubEventsDataSource(events: events))
    view.stopLoadingIfNeeded()
  }
}
