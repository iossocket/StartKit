//
//  GitHubLoginPresenterSpec.swift
//  StartKitTests
//
//  Created by Xin Guo  on 2018/6/5.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Quick
import Nimble
@testable import StartKit

class GitHubLoginPresenterSpec: QuickSpec {
  override func spec() {
    describe("dismissLoginView") {
      let loginView = MockGitHubLoginView()
      let presenter = GitHubLoginPresenter(view: loginView)
      
      beforeEach {
        presenter.dismissLoginView()
      }
      
      it("calls view's dismiss method") {
        expect(loginView.dismissInvolvedCount) == 1
      }
    }
  }
}

private class MockGitHubLoginView: GitHubLoginView {
  var dismissInvolvedCount: Int = 0
  var dismiss: (() -> Void)?
  
  init() {
    dismiss = {
      self.dismissInvolvedCount += 1
    }
  }
}
