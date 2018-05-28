//
//  MockCoreDataStack.swift
//  StartKitTests
//
//  Created by Xin Guo  on 2018/5/29.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData
@testable import StartKit

class MockCoreDataStack: CoreDataStack {
  enum StoreType {
    case inMemory
    case sqlite
  }
  
  private var _storeType: StoreType = .inMemory
  var storeType: StoreType {
    get {
      return _storeType
    }
    set {
      _storeType = newValue
      managedObjectContext = createManagedObjectContext()
    }
  }
  
  private func createManagedObjectContext() -> NSManagedObjectContext {
    let coordinator = persistentStoreCoordinator
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
  }
  
  private lazy var inMemoryCoordinator: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let url = applicationDocumentsDirectory.appendingPathComponent("GitHub_Test.sqlite")
    print("CoreData sqlite URL: \(url.absoluteString)")
    let failureReason = "There was an error creating or loading the application's saved data."
    let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true as Bool), NSInferMappingModelAutomaticallyOption: NSNumber(value: true as Bool)]
    do {
      try coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: url, options: options)
    } catch {
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
      dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
      
      dict[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: CoreDataErrorDomain, code: 9999, userInfo: dict)
      NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
      abort()
    }
    
    return coordinator
  }()
  
  private lazy var sqliteCoordinator: NSPersistentStoreCoordinator = {
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let url = applicationDocumentsDirectory.appendingPathComponent("GitHub_Test.sqlite")
    print("CoreData sqlite URL: \(url.absoluteString)")
    let failureReason = "There was an error creating or loading the application's saved data."
    let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true as Bool), NSInferMappingModelAutomaticallyOption: NSNumber(value: true as Bool)]
    do {
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
    } catch {
      var dict = [String: AnyObject]()
      dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
      dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
      
      dict[NSUnderlyingErrorKey] = error as NSError
      let wrappedError = NSError(domain: CoreDataErrorDomain, code: 9999, userInfo: dict)
      NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
      abort()
    }
    
    return coordinator
  }()
  
  override var persistentStoreCoordinator: NSPersistentStoreCoordinator {
    get {
      switch storeType {
      case .inMemory:
        return inMemoryCoordinator
      case .sqlite:
        return sqliteCoordinator
      }
    }
    set {}
  }
}

