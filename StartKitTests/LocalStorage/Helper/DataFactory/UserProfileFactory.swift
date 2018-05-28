//
//  UserProfileFactory.swift
//  StartKitTests
//
//  Created by Xin Guo  on 2018/5/29.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
@testable import StartKit

class UserProfileFactory {
  class func build() -> UserProfile {
    return UserProfile(
      id: 111111,
      login: "username",
      avatar_url: "https://myavatar.com/avatar-url",
      name: "name",
      company: "company",
      blog: "blog",
      email: "email@email.com",
      public_repos: 10,
      repos_url: "https://repourl.com/repos-url",
      received_events_url: "https://receivedevents.com/events-url"
    )
  }
}
