//
//  SpecificRepo.swift
//  StartKit
//
//  Created by XueliangZhu on 11/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import ObjectMapper

class SpecificRepo: Mappable {
    var name: String?
    var language: String?
    var description: String?
    
    var createDate: Date?
    var updateDate: Date?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name          <- map["full_name"]
        language      <- map["language"]
        description   <- map["description"]
        updateDate    <- (map["updated_at"], DateTransform())
        createDate    <- (map["created_at"], DateTransform())
    }
}
