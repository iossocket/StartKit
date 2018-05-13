//
//  UserDBObject.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

struct UserMapper: DBMapper {
  typealias DBObject = User
  typealias Domain = UserProfile
  
  let entityName: String = "User"
  
  private var context: NSManagedObjectContext {
    return CoreDataStack.managedObjectContext
  }
  
  private var entityDescription: NSEntityDescription? {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      return nil
    }
    return entityDescription
  }
  
  func map(domain: UserProfile) -> User? {
    guard let entityDescription = entityDescription else {
      return nil
    }
    
    let user = User(entity: entityDescription, insertInto: context)
    user.id = domain.id
    user.login = domain.login
    user.name = domain.name
    user.avatarUrl = domain.avatar_url
    user.email = domain.email
    user.blog = domain.blog
    user.company = domain.company
    user.publicRepos = domain.public_repos
    user.reposUrl = domain.repos_url
    user.receivedEventsUrl = domain.received_events_url
    
    return user
  }
  
  func map(dbObject: User) -> UserProfile? {
    return UserProfile(
      id: dbObject.id,
      login: dbObject.login ?? "",
      avatar_url: dbObject.avatarUrl ?? "",
      name: dbObject.name ?? "",
      company: dbObject.company ?? "",
      blog: dbObject.blog ?? "",
      email: dbObject.email ?? "",
      public_repos: dbObject.publicRepos,
      repos_url: dbObject.reposUrl ?? "",
      received_events_url: dbObject.receivedEventsUrl ?? ""
    )
  }
}
