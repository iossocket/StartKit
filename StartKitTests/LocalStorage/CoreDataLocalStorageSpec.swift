//
//  CoreDataLocalStorageSpec.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/27.
//Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Quick
import Nimble
@testable import StartKit

import CoreData
import RxSwift

class CoreDataLocalStorageSpec: QuickSpec {
  override func spec() {
    let disposeBag = DisposeBag()
    var coreDataStack: MockCoreDataStack!
    var localStorage: CoreDataLocalStorage!
    var userMapper: UserMapper!
    
    let resetDB = {
      coreDataStack = MockCoreDataStack()
      localStorage = CoreDataLocalStorage(coredataStack: coreDataStack)
      userMapper = UserMapper(context: coreDataStack.managedObjectContext)
    }
    
    describe("save") {
      context("when we save a user in db") {
        beforeEach {
          resetDB()
          
          let userProfile = UserProfileFactory.build()
          localStorage.save(object: userProfile, mapper: userMapper)
        }
        
        it("has a user in db") {
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: userMapper.entityName)
          expect(try? coreDataStack.managedObjectContext.count(for: request)) == 1
        }
      }
    }
    
    describe("queryOne") {
      context("when there is one or more users in db") {
        var userProfile: UserProfile? = nil
        
        beforeEach {
          resetDB()
          
          let userProfile = UserProfileFactory.build()
          localStorage.save(object: userProfile, mapper: userMapper)
        }
        
        it("has one user in db") {
          localStorage.queryOne(withMapper: userMapper)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { user in
              userProfile = user
            }).disposed(by: disposeBag)
          
          expect(userProfile).toNot(beNil())
        }
      }
      
      context("when there no user in db") {
        var userProfile: UserProfile? = nil
        
        beforeEach {
          resetDB()
        }
        
        it("has no user in db") {
          localStorage.queryOne(withMapper: userMapper)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { user in
              userProfile = user
            }).disposed(by: disposeBag)
          
          expect(userProfile).to(beNil())
        }
      }
    }
    
    describe("deleteAllObjects(for:)") {
      context("when there is one user in db") {
        beforeEach {
          resetDB()
          coreDataStack.storeType = .sqlite
          
          let userProfile = UserProfileFactory.build()
          localStorage.save(object: userProfile, mapper: UserMapper(context: coreDataStack.managedObjectContext))
        }
        
        it("has no user in db after deleting") {
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: userMapper.entityName)
          expect(try? coreDataStack.managedObjectContext.count(for: request)) == 1
          localStorage.deleteAllObjects(for: userMapper.entityName)
          expect(try? coreDataStack.managedObjectContext.count(for: request)) == 0
        }
      }
    }
  }
}
