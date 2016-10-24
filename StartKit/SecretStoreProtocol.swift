//
//  SecretStoreProtocol.swift
//  StartKit
//
//  Created by XueliangZhu on 10/20/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation

protocol SecretStoreProtocol {
    func saveToken(token: String?)
    func getToken() -> String
    func emptyToken()
}
