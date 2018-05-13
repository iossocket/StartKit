//
//  GitHubNewsViewController.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import UIKit

protocol GitHubEventsView {
  func configure(with dataSource: GitHubEventsDataSource)
  func stopLoadingIfNeeded()
}

class GitHubEventsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private let eventCellNibName = "GitHubEventCell"
  static let eventCellReuseIdentifier = "GitHubEventCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: eventCellNibName, bundle: nil), forCellReuseIdentifier: GitHubEventsViewController.eventCellReuseIdentifier)
  }
}

extension GitHubEventsViewController: GitHubEventsView {
  func configure(with dataSource: GitHubEventsDataSource) {
    tableView.dataSource = dataSource
    tableView.reloadData()
  }
  
  func stopLoadingIfNeeded() {
    
  }
}
