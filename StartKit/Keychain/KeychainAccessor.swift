//
//  KeychainAccessor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

struct KeychainAccessor {
  func currentAccount() -> (account: String, password: String)? {
    do {
      let passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
      let currentAccount = passwordItems.first
      guard let account = currentAccount?.account, let password = try currentAccount?.readPassword() else {
        return nil
      }
      return (account, password)
    } catch {
      print("Error reading password from keychain - \(error)")
      return nil
    }
  }
  
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
      return ""
    }
  }
  
  func clearAccount() {
    do {
      let passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: KeychainConfiguration.accessGroup)
      try passwordItems.forEach { try $0.deleteItem() }
    } catch {
      print("Error deleting password items - \(error)")
    }
  }
}
