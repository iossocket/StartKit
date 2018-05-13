//
//  Event.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct Event: Decodable {
  var id: String
  var type: String
  var actor: Actor
  var repo: Repo
  var payload: Payload
  var created_at: String
  
  struct Actor: Decodable {
    var id: Int
    var login: String
    var display_login: String
    var avatar_url: String
  }
  
  struct Repo: Decodable {
    var id: Int
    var name: String
    var url: String
  }
  
  struct Payload: Decodable {
    var ref_type: String?
    var action: String?
    var member: Member?
    var forkee: Forkee?
  }
  
  struct Member: Decodable {
    var login: String
    var avatar_url: String
  }
  
  struct Forkee: Decodable {
    var id: Int
    var name: String
    var full_name: String
  }
}
