//
//  UserProfile.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct UserProfile: Decodable {
  var id: Int64
  var login: String
  var avatar_url: String
  var name: String
  var company: String
  
  var blog: String
  var email: String
  var public_repos: Int32
  
  var repos_url: String
  var received_events_url: String
}
