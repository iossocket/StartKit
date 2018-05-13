//
//  UserDBObject.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct UserDBObject: DBObject {
  typealias Domain = UserProfile
  
  let entityName: String = "User"
  let domain: UserProfile
}
