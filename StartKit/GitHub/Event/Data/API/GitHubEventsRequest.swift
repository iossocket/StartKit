//
//  GitHubEventsRequest.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct GitHubEventsRequest: Request {
  typealias Response = [Event]
  
  var username: String
  var path: String
  let method: HTTPMethod = .get
  let parameter: [String : Any] = [:]
  var headers: [String : String]? = nil
  let encoding: ParameterEncoding? = nil
}

extension GitHubEventsRequest {
  init(username: String) {
    self.username = username
    self.path = "/users/\(username)/received_events"
  }
}
