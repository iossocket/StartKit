//
//  UserProfile+DBObjectConvertable.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import CoreData

extension UserProfile: DBObjectConvertable {
  typealias DBObject = User
  
  func toDBObject(entityName: String) -> User? {
    let context = CoreDataStack.managedObjectContext
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      return nil
    }
    
    let user = User(entity: entityDescription, insertInto: context)
    
    user.id = id
    user.login = login
    user.name = name
    user.avatarUrl = avatar_url
    user.email = email
    user.blog = blog
    user.company = company
    user.publicRepos = public_repos
    user.reposUrl = repos_url
    user.receivedEventsUrl = received_events_url
    
    return user
  }
}
