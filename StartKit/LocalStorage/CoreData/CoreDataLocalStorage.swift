//
//  CoreDataLocalStorage.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

class CoreDataLocalStorage: LocalStorage {
  func save<T: DBObject>(object: T) {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: object.entityName, in: CoreDataStack.managedObjectContext) else {
      return
    }
    object.domain.toManagedObject(entityDescription: entityDescription, context: CoreDataStack.managedObjectContext)
    CoreDataStack.saveContext()
  }
}
