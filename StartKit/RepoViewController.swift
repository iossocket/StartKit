//
//  RepoViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 10/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = KeychainSecretStore().getToken() else {
            let loginVC = UIStoryboard(name: "Login", bundle: nil)
                .instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC, animated: true, completion: nil)
            return
        }
    }
}
