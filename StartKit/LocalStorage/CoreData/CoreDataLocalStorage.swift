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
  func save<T: DBMapper>(object: T) {
    object.domain?.toDBObject(entityName: object.entityName)
    CoreDataStack.saveContext()
  }
  
  func queryOne<T: DBMapper>(with object: T, completion: @escaping (T.Domain) -> ()) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: object.entityName)
    request.fetchLimit = 1
    do {
      guard let fetchedObjects = try CoreDataStack.managedObjectContext.fetch(request) as? [T.DBObject],
        let domain = fetchedObjects.first?.toDomainObject() else {
        return
      }
      completion(domain)
    } catch {
      
    }
  }
}
