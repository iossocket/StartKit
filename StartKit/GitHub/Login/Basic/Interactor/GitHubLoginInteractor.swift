//
//  GitHubLoginInteractor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/10.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubLoginInteractorProtocol {
  func login(withEmailOrUsername: String, password: String)
  func loginViaOAuth()
}

class GitHubLoginInteractor: GitHubLoginInteractorProtocol {
  private let client: RxClient
  private let presenter: GitHubLoginPresenterProtocol
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(client: RxClient, presenter: GitHubLoginPresenterProtocol) {
    self.client = client
    self.presenter = presenter
  }
  
  func login(withEmailOrUsername emailOrUsername: String, password: String) {
    guard let request = GitHubLoginRequest(username: emailOrUsername, password: password) else {
      return
    }
    
    client.send(request).observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] response in
        print(response)
        self?.presenter.dismissLoginView()
        // TODO: Localize user profile
        // TODO: dismiss login view controller
      }, onError: { error in
        print(error.localizedDescription)
      }).disposed(by: disposeBag)
  }
  
  func loginViaOAuth() {
    fatalError("GitHubLoginInteractorProtocol.LoginViaOAuth not implemented yet!")
  }
}
