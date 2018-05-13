//
//  GitHubEventCellViewModel.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct GitHubEventCellViewModel {
  private let event: Event
  
  init(event: Event) {
    self.event = event
  }
  
  var avatorURL: URL? {
    return URL(string: event.actor.avatar_url)
  }
  
  var time: String {
    return event.created_at
  }
  
  var description: String {
    return ""
  }
}
