//
//  User.swift
//  StartKit
//
//  Created by XueliangZhu on 10/17/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var avatarUrl: String?
    var name: String?
    
    required init?(map: Map) {
        if map.JSON["name"] == nil || map.JSON["avatar_url"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        avatarUrl   <- map["avatar_url"]
        name        <- map["name"]
    }
}
