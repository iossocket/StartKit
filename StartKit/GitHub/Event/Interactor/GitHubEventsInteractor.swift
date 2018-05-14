//
//  GitHubEventsInteractor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubEventsInteractorProtocol {
  func loadEvents()
}

class GitHubEventsInteractor: GitHubEventsInteractorProtocol {
  private let presenter: GitHubEventsPresenterProtocol
  private let localStorage: LocalStorage
  private let client: RxClient
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(presenter: GitHubEventsPresenterProtocol, client: RxClient, localStorage: LocalStorage) {
    self.presenter = presenter
    self.localStorage = localStorage
    self.client = client
  }
  
  func loadEvents() {
    localStorage.queryOne(withMapper: UserMapper()) { [weak self] (userProfile, error) in
      guard let strongSelf = self, let username = userProfile?.login else {
        self?.presenter.configureEventList(with: [])
        return
      }
      
      let request = GitHubEventsRequest(username: username)
      strongSelf.client.send(request).observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] events in
          self?.presenter.configureEventList(with: events)
        }, onError: { error in
          print("RxClient fetching events failed: \(error.localizedDescription)")
        }).disposed(by: strongSelf.disposeBag)
    }
  }
}
