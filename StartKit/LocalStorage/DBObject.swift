//
//  DBObject.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

protocol DBObject {
  associatedtype Domain: DBObjectConvertable
  
  var entityName: String { get }
  var domain: Domain { get }
}
