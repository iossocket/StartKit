//
//  DBObject.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

protocol DBMapper {
  associatedtype DBObject
  associatedtype Domain
  
  var entityName: String { get }
  
  @discardableResult
  func map(domain: Domain) -> DBObject?
  func map(dbObject: DBObject) -> Domain?
}
