//
//  GitHubLoginRequestSpec.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/6/5.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Quick
import Nimble
@testable import StartKit

class GitHubLoginRequestSpec: QuickSpec {
  override func spec() {
    describe("request") {
      let username = "username"
      let password = "password"
      let request = GitHubLoginRequest(username: username, password: password)
      
      it("has path equal to /user") {
        expect(request?.path) == "/user"
      }
      
      it("has post http method") {
        expect(request?.method.rawValue) == HTTPMethod.post.rawValue
      }
      
      it("encode parameter as json") {
        expect(request?.encoding) == ParameterEncoding.json
      }
      
      it("has empty parameter") {
        expect(request?.parameter.count) == 0
      }
      
      it("has header with authenticated username and password") {
        expect(request?.headers?["Authorization"]) == "Basic dXNlcm5hbWU6cGFzc3dvcmQ="
      }
    }
  }
}
