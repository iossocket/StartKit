//
//  GitHubBasicLoginRequest.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/11.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct GitHubLoginRequest: Request {
  typealias Response = UserProfile
  
  let path: String = "/user"
  let method: HTTPMethod = .post
  let parameter: [String : Any] = [:]
  var headers: [String : String]? = [:]
  let encoding: ParameterEncoding? = .json
}

extension GitHubLoginRequest {
  init?(username: String, password: String) {
    guard let encodedAuthentication = base64Encode(emailOrUsername: username, password: password) else {
      return nil
    }
    
    headers?["Authorization"] = "Basic \(encodedAuthentication)"
  }
  
  private func base64Encode(emailOrUsername: String, password: String) -> String? {
    let credentialsData = "\(emailOrUsername):\(password)".data(using: .utf8)
    let base64Credentials = credentialsData?.base64EncodedString()
    return base64Credentials
  }
}

struct UserProfile: Decodable {
  var id: Int
  var login: String
  var avatar_url: String
  var name: String
  var company: String
  
  var blog: String
  var email: String
  var public_repos: Int
  
  var repos_url: String
  var received_events_url: String
}
