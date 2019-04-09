//
//  AppDelegate.swift
//  StartKit
//
//  Created by XueliangZhu on 9/24/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        (window?.rootViewController as? UITabBarController)?.tabBar.tintColor = UIColor.red
//        KeychainSecretStore().emptyLoginResult()
        return true
    }
}
