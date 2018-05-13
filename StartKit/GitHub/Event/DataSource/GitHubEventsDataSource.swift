//
//  GitHubEventsDataSource.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/14.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit

class GitHubEventsDataSource: NSObject, UITableViewDataSource {
  private let events: [Event]
  
  init(events: [Event]) {
    self.events = events
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: GitHubEventsViewController.eventCellReuseIdentifier, for: indexPath) as? GitHubEventCell else {
      return UITableViewCell()
    }
    cell.configure(with: events[indexPath.row])
    return cell
  }
}
