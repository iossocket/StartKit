//
//  CoreDataLocalStorage.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class CoreDataLocalStorage: LocalStorage {
  private let coredataStack: CoreDataStack
  
  init(coredataStack: CoreDataStack = CoreDataStack.shared) {
    self.coredataStack = coredataStack
  }
  
  func save<M: DBMapper>(object: M.Domain, mapper: M) {
    mapper.map(domain: object)
    coredataStack.saveContext()
  }
  
  func queryOne<M: DBMapper>(withMapper mapper: M) -> Observable<M.Domain?> {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: mapper.entityName)
    request.fetchLimit = 1
    
    do {
      guard
        let fetchedObjects = try coredataStack.managedObjectContext.fetch(request) as? [M.DBObject],
        let object = fetchedObjects.first,
        let domain = mapper.map(dbObject: object) else {
          return Observable.just(nil)
      }
      return Observable.just(domain)
    } catch {
      return Observable.error(error)
    }
  }
  
  func deleteAllObjects(for entityName: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    do {
      try coredataStack.persistentStoreCoordinator.execute(deleteRequest, with: coredataStack.managedObjectContext)
      coredataStack.saveContext()
    } catch {
      print("CoreData delete objects failed: \(error.localizedDescription)")
    }
  }
}
