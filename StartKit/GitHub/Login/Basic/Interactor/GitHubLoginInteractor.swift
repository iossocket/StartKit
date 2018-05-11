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
    guard let encodedAuthentication = base64Encode(emailOrUsername: emailOrUsername, password: password) else {
      return
    }
    let request = GitHubBasicLoginRequest(headers: ["Authorization": "Basic \(encodedAuthentication)"])
    client.send(request).observeOn(MainScheduler.instance)
      .subscribe(onNext: { response in
        
      }, onError: { _ in
        
      }).disposed(by: disposeBag)
  }
  
  func loginViaOAuth() {
    fatalError("GitHubLoginInteractorProtocol.LoginViaOAuth not implemented yet!")
  }
  
  private func base64Encode(emailOrUsername: String, password: String) -> String? {
    let data = "\(emailOrUsername):\(password))".data(using: .utf8)
    let base64 = data?.base64EncodedString()
    return base64
  }
}
