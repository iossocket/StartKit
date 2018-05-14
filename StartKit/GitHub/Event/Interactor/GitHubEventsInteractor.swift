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
  private let keychainAccessor: KeychainAccessor
  private let client: RxClient
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(presenter: GitHubEventsPresenterProtocol, client: RxClient, localStorage: LocalStorage, keychainAccessor: KeychainAccessor) {
    self.presenter = presenter
    self.localStorage = localStorage
    self.client = client
    self.keychainAccessor = keychainAccessor
  }
  
  func loadEvents() {
    guard let username = keychainAccessor.currentAccount()?.0,
      let password = keychainAccessor.currentAccount()?.1 else {
        presenter.configureEventList(with: [])
        return
    }
    let request = GitHubEventsRequest(username: username, password: password)
    client.send(request).observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] events in
        self?.presenter.configureEventList(with: events)
        }, onError: { error in
          print("RxClient fetching events failed: \(error.localizedDescription)")
      }).disposed(by: disposeBag)
  }
}
