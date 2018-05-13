//
//  CoreDataObjConvertable.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

protocol DBObjectConvertable {
  associatedtype DBObject: DomainConvertable
  
  @discardableResult
  func toDBObject(entityName: String) -> DBObject?
}
