//
//  KeychainAccessor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct KeychainAccessor {
  func savePassword(_ password: String, into account: String) {
    do {
      let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: account, accessGroup: KeychainConfiguration.accessGroup)
      try passwordItem.savePassword(password)
    } catch {
      print("Error saving password from keychain - \(error)")
    }
  }
  
  func readPassword(for account: String) -> String {
    do {
      let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: account, accessGroup: KeychainConfiguration.accessGroup)
      return try passwordItem.readPassword()
    } catch {
      print("Error reading password from keychain - \(error)")
    }
  }
  
  func clearAccount() {
    do {
      let passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
      passwordItems.forEach { try $0.deleteItem() }
    } catch {
      print("Error deleting password items - \(error)")
    }
  }
}
