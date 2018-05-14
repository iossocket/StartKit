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
  private let refreshControl = UIRefreshControl()
  private var dataSource: GitHubEventsDataSource!
  
  private let eventCellNibName = "GitHubEventCell"
  static let eventCellReuseIdentifier = "GitHubEventCell"
  
  var interactor: GitHubEventsInteractor!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    GitHubEventConfiguration.configure(viewController: self)
    setupTableView()
    setupRefreshControl()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    interactor.loadEvents()
    refreshControl.beginRefreshing()
  }
  
  private func setupTableView() {
    tableView.register(UINib(nibName: eventCellNibName, bundle: nil), forCellReuseIdentifier: GitHubEventsViewController.eventCellReuseIdentifier)
    tableView.tableFooterView = UIView()
  }
  
  private func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(reloadEvents), for: .valueChanged)
    tableView.addSubview(refreshControl)
  }
  
  @objc private func reloadEvents() {
    interactor.loadEvents()
  }
}

extension GitHubEventsViewController: GitHubEventsView {
  func configure(with dataSource: GitHubEventsDataSource) {
    self.dataSource = dataSource
    tableView.dataSource = self.dataSource
    tableView.reloadData()
  }
  
  func stopLoadingIfNeeded() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.refreshControl.endRefreshing()
    }
  }
}
