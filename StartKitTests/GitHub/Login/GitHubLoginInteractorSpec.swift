//
//  GitHubLoginInteractorSpec.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/29.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Quick
import Nimble
@testable import StartKit

import RxSwift

class GitHubLoginInteractorSpec: QuickSpec {
  override func spec() {
    var mockClient: MockRxClient!
    var mockLocalStorage: MockLocalStorage!
    var mockKeychainAccessor: MockKeychainAccessor!
    var mockPresenter: MockGitHubLoginPresenter!
    var interactor: GitHubLoginInteractor!

    let reset = {
      mockClient = MockRxClient()
      mockLocalStorage = MockLocalStorage()
      mockKeychainAccessor = MockKeychainAccessor()
      mockPresenter = MockGitHubLoginPresenter()
      interactor = GitHubLoginInteractor(client: mockClient, localStorage: mockLocalStorage, keychainAccessor: mockKeychainAccessor, presenter: mockPresenter)
    }
  }
}

private class MockRxClient: RxClient {
  var configureWithCachePolicyInvolvedCount = 0
  var sendInvolvedCount = 0

  var sendMethodReturnValue: Any?

  func configure(cachePolicy: NSURLRequest.CachePolicy) {
    configureWithCachePolicyInvolvedCount += 1
  }

  func send<T: Request>(_ r: T) -> Observable<T.Response> {
    sendInvolvedCount += 1
    return Observable.just(sendMethodReturnValue as! T.Response)
  }

  var host: String = "https://www.test-host.com"
}

private class MockLocalStorage: LocalStorage {
  var saveInvolvedCount = 0
  var queryOneInvolvedCount = 0
  var deleteAllObjectsInvolvedCount = 0

  var queryOneMethodReturnValue: Any?

  func save<M: DBMapper>(object: M.Domain, mapper: M) {
    saveInvolvedCount += 1
  }

  func queryOne<M: DBMapper>(withMapper mapper: M) -> Observable<M.Domain?> {
    queryOneInvolvedCount += 1
    return Observable.just(queryOneMethodReturnValue as? M.Domain)
  }

  func deleteAllObjects(for entityName: String) {
    deleteAllObjectsInvolvedCount += 1
  }
}

private class MockKeychainAccessor: KeychainAccessorProtocol {
  var currentAccountInvolvedCount = 0
  var savePasswordInvolvedCount = 0
  var readPasswordInvolvedCount = 0
  var clearAccountInvolvedCount = 0

  var returnedAccount: String = ""
  var returnedPassword: String = ""

  func currentAccount() -> (account: String, password: String)? {
    currentAccountInvolvedCount += 1
    return (returnedAccount, returnedPassword)
  }

  func savePassword(_ password: String, into account: String) {
    savePasswordInvolvedCount += 1
  }

  func readPassword(for account: String) -> String {
    readPasswordInvolvedCount += 1
    return returnedPassword
  }

  func clearAccount() {
    clearAccountInvolvedCount += 1
  }
}

private class MockGitHubLoginPresenter: GitHubLoginPresenterProtocol {
  var dismissLoginViewInvolvedCount = 0

  func dismissLoginView() {
    dismissLoginViewInvolvedCount += 1
  }
}
