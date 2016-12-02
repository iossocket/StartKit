//
//  MeViewController.swift
//  StartKit
//
//  Created by XueliangZhu on 10/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        let loginVC = UIStoryboard(name: "Login", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.status = .logout
        self.present(loginVC, animated: true, completion: nil)
    }
}
