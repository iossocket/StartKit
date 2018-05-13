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
  func toManagedObject(entityDescription: NSEntityDescription, context: NSManagedObjectContext) -> NSManagedObject {
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
