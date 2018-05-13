//
//  User+DomainConvertable.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

extension User: DomainConvertable {
  typealias Domain = UserProfile
  
  func toDomainObject() -> UserProfile? {
    return UserProfile(
      id: id,
      login: login ?? "",
      avatar_url: avatarUrl ?? "",
      name: name ?? "",
      company: company ?? "",
      blog: blog ?? "",
      email: email ?? "",
      public_repos: publicRepos,
      repos_url: reposUrl ?? "",
      received_events_url: receivedEventsUrl ?? ""
    )
  }
}
