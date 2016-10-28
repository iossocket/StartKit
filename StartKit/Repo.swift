//
//  Repo.swift
//  StartKit
//
//  Created by XueliangZhu on 10/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import ObjectMapper

class Repo: Mappable {
    var name: String?
    var gitUrl: String?
    var htmlUrl: String?
    
    var pushedDate: Date?
    var updateDate: Date?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name          <- map["name"]
        gitUrl        <- map["git_url"]
        htmlUrl       <- map["html_url"]
        pushedDate    <- (map["pushed_at"], DateTransform())
        updateDate    <- (map["updated_at"], DateTransform())
    }
}

class DateTransform: TransformType {
    func transformFromJSON(_ value: Any?) -> Date? {
        guard let dataString = value as? String else {
            return nil
        }
        
        let timeFormatterUTC = DateFormatter()
        timeFormatterUTC.timeZone = TimeZone.current
        timeFormatterUTC.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        guard let date = timeFormatterUTC.date(from: dataString) else {
            return nil
        }
        
        return date
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        return nil
    }
}
