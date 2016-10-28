//
//  RepoViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 10/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit
import SVProgressHUD

class RepoViewController: UIViewController {
    
    let repoApiManager = RepoAPIManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let token = KeychainSecretStore().getToken() else {
            showLoginPage()
            return
        }
        fetchRepos(token: token)
    }
    
    private func showLoginPage() {
        let loginVC = UIStoryboard(name: "Login", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginVC, animated: true, completion: nil)
    }
    
    private func fetchRepos(token: String) {
        SVProgressHUD.show()
        repoApiManager.fetchAllRepos(token: token) { result in
            switch (result) {
            case RepoResult.success(let repos):
                print(repos)
                SVProgressHUD.dismiss()
            case RepoResult.failure:
                SVProgressHUD.showError(withStatus: "Fetch repo failed")
            }
        }
    }
}
