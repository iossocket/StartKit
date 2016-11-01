//
//  SecretStoreProtocol.swift
//  StartKit
//
//  Created by XueliangZhu on 10/20/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation

protocol SecretStoreProtocol {
    func saveLoginResult(_ loginResult: (token: String, id: String))
    func getToken() -> String?
    func getId() -> String?
    func emptyLoginResult()
}
