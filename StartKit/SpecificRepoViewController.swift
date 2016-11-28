//
//  SpecificRepoViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 11/27/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit
import SVProgressHUD

class SpecificRepoViewController: UIViewController {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    var repoName: String!
    fileprivate let userInfo = UserInfoService()
    fileprivate let repoApiManager = RepoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = UIColor.white
        navigationItem.title = repoName
        guard let user = userInfo.getUserInfo()?.name else {
            return
        }
        SVProgressHUD.show()
        repoApiManager.fetchRepo(name: repoName, user: user, handler: {[weak self] in
            switch $0 {
            case .success(let repo):
                self?.fullName.text = repo.name ?? "Unknown"
                self?.descriptions.text = repo.description ?? "No description"
                self?.language.text = repo.language ?? "Unknown"
                self?.createDate.text = repo.createDate?.description ?? "Unknown"
                self?.updateDate.text = repo.updateDate?.description ?? "Unkonwn"
                SVProgressHUD.dismiss()
            case .failure:
                SVProgressHUD.showError(withStatus: "Fetch repo failed")
            }
        })
    }
}
