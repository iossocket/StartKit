//
//  UserInfoService.swift
//  StartKit
//
//  Created by XueliangZhu on 10/27/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

protocol UserInfoProtocol {
    func getUserInfo() -> User?
    func saveUserInof(user: User) -> Bool
}

class UserInfoService: UserInfoProtocol {
    
    let NAME = "name"
    let URL = "avatarurl"
    
    func getUserInfo() -> User? {
        let userDefaults = UserDefaults()
        guard let name = userDefaults.string(forKey: NAME), let avatarUrl = userDefaults.string(forKey: URL) else {
            return nil
        }
        return User(name: name, avatarUrl: avatarUrl)
    }
    
    func saveUserInof(user: User) -> Bool {
        let userDefaults = UserDefaults()
        guard let name = user.name, let avatarUrl = user.avatarUrl else {
            return false
        }
        userDefaults.set(name, forKey: NAME)
        userDefaults.set(avatarUrl, forKey: URL)
        return userDefaults.synchronize()
    }
}
