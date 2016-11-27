//
//  RepoDataSource.swift
//  StartKit
//
//  Created by XueliangZhu on 10/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class RepoViewModel: NSObject {
    fileprivate var repos = Array<Repo>()
    
    func setRepos(_ repos: Array<Repo>) {
        self.repos = repos
    }
    
    func getRepoBy(_ index: IndexPath) -> Repo {
        return repos[index.row]
    }
}

extension RepoViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        cell.textLabel?.text = repos[indexPath.row].name
        return cell
    }
}
