//
//  GitHubBasicLoginRequest.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/11.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct GitHubBasicLoginRequest: Request {
  typealias Response = UserProfile
  
  let path: String = "/user"
  let method: HTTPMethod = .post
  let parameter: [String : Any] = [:]
  var headers: [String : String]? = [:]
  let encoding: ParameterEncoding? = .json
}

struct UserProfile: Decodable {
  var login: String
  var avatar_url: String
}
