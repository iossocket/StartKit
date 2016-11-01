//
//  KeychainSecretStore.swift
//  StartKit
//
//  Created by XueliangZhu on 10/20/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeychainSecretStore: SecretStoreProtocol {
    
    let keychain: Keychain
    let GITHUB_TOKEN = "github_token"
    let GITHUB_ID = "github_id"
    
    init() {
        keychain = Keychain()
    }
    
    func saveLoginResult(_ loginResult: (token: String, id: String)) {
        keychain[GITHUB_TOKEN] = loginResult.token
        keychain[GITHUB_ID] = loginResult.id
    }
    
    func getToken() -> String? {
        return keychain[GITHUB_TOKEN]
    }
    
    func getId() -> String? {
        return keychain[GITHUB_ID]
    }
    
    func emptyLoginResult() {
        keychain[GITHUB_TOKEN] = nil
        keychain[GITHUB_ID] = nil
    }
}
