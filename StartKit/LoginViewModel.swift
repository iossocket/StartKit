//
//  LoginViewModel.swift
//  StartKit
//
//  Created by XueliangZhu on 10/27/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import UIKit

struct LoginViewModel {
    let userInfo: UserInfoProtocol
    let keychainService: SecretStoreProtocol
    
    init(userInfo: UserInfoProtocol, keychainService: SecretStoreProtocol) {
        self.userInfo = userInfo
        self.keychainService = keychainService
    }
    
    func getUserInfo() -> (name: String, avatarUrl: String)? {
        guard let user = userInfo.getUserInfo() else {
            return nil
        }
        
        guard let name = user.name, let url = user.avatarUrl else {
            return nil
        }
        return (name: name, avatarUrl: url)
    }
    
    func isUserNameOrPasswordEmpty(userName: String, password: String) -> Bool {
        if userName.isEmpty || password.isEmpty {
            return true
        }
        return false
    }
    
    func saveUserInfoAndLoginResult(user: User, loginResult: (token: String, id: String)) -> Bool {
        if !userInfo.saveUserInfo(user: user) {
            return false
        }
        keychainService.saveLoginResult(loginResult)
        return true
    }
    
    func getTokenAndId() -> (token: String, id: String)? {
        guard let id = keychainService.getId(), let token = keychainService.getToken() else {
            return nil
        }
        return (token, id)
    }
    
    func emptyToken() {
        keychainService.emptyLoginResult()
    }
}
