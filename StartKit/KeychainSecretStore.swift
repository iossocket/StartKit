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
    
    init() {
        keychain = Keychain()
    }
    
    func saveToken(token: String) {
        keychain[GITHUB_TOKEN] = token
    }
    
    func getToken() -> String? {
        return keychain[GITHUB_TOKEN]
    }
    
    func emptyToken() {
        keychain[GITHUB_TOKEN] = nil
    }
}
