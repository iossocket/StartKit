/*
 Sample code project: GenericKeychain
 Version: 4.0
 
 IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 
 Abstract:
 A simple struct that defines the service and access group to be used by the sample apps.
 */

import Foundation

struct KeychainPasswordItem {
  // MARK: Types
  
  enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unexpectedItemData
    case unhandledError(status: OSStatus)
  }
  
  // MARK: Properties
  
  let service: String
  
  private(set) var account: String
  
  let accessGroup: String?
  
  // MARK: Intialization
  
  init(service: String, account: String, accessGroup: String? = nil) {
    self.service = service
    self.account = account
    self.accessGroup = accessGroup
  }
  
  // MARK: Keychain access
  
  func readPassword() throws -> String  {
    /*
     Build a query to find the item that matches the service, account and
     access group.
     */
    var query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
    query[kSecMatchLimit as String] = kSecMatchLimitOne
    query[kSecReturnAttributes as String] = kCFBooleanTrue
    query[kSecReturnData as String] = kCFBooleanTrue
    
    // Try to fetch the existing keychain item that matches the query.
    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }
    
    // Check the return status and throw an error if appropriate.
    guard status != errSecItemNotFound else { throw KeychainError.noPassword }
    guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    
    // Parse the password string from the query result.
    guard let existingItem = queryResult as? [String : AnyObject],
      let passwordData = existingItem[kSecValueData as String] as? Data,
      let password = String(data: passwordData, encoding: String.Encoding.utf8)
      else {
        throw KeychainError.unexpectedPasswordData
    }
    
    return password
  }
  
  func savePassword(_ password: String) throws {
    // Encode the password into an Data object.
    let encodedPassword = password.data(using: String.Encoding.utf8)!
    
    do {
      // Check for an existing item in the keychain.
      try _ = readPassword()
      
      // Update the existing item with the new password.
      var attributesToUpdate = [String : AnyObject]()
      attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
      
      let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
      let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
      
      // Throw an error if an unexpected status was returned.
      guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    }
    catch KeychainError.noPassword {
      /*
       No password was found in the keychain. Create a dictionary to save
       as a new keychain item.
       */
      var newItem = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
      newItem[kSecValueData as String] = encodedPassword as AnyObject?
      
      // Add a the new item to the keychain.
      let status = SecItemAdd(newItem as CFDictionary, nil)
      
      // Throw an error if an unexpected status was returned.
      guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    }
  }
  
  mutating func renameAccount(_ newAccountName: String) throws {
    // Try to update an existing item with the new account name.
    var attributesToUpdate = [String : AnyObject]()
    attributesToUpdate[kSecAttrAccount as String] = newAccountName as AnyObject?
    
    let query = KeychainPasswordItem.keychainQuery(withService: service, account: self.account, accessGroup: accessGroup)
    let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    
    // Throw an error if an unexpected status was returned.
    guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    
    self.account = newAccountName
  }
  
  func deleteItem() throws {
    // Delete the existing item from the keychain.
    let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
    let status = SecItemDelete(query as CFDictionary)
    
    // Throw an error if an unexpected status was returned.
    guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
  }
  
  static func passwordItems(forService service: String, accessGroup: String? = nil) throws -> [KeychainPasswordItem] {
    // Build a query for all items that match the service and access group.
    var query = KeychainPasswordItem.keychainQuery(withService: service, accessGroup: accessGroup)
    query[kSecMatchLimit as String] = kSecMatchLimitAll
    query[kSecReturnAttributes as String] = kCFBooleanTrue
    query[kSecReturnData as String] = kCFBooleanFalse
    
    // Fetch matching items from the keychain.
    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }
    
    // If no items were found, return an empty array.
    guard status != errSecItemNotFound else { return [] }
    
    // Throw an error if an unexpected status was returned.
    guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    
    // Cast the query result to an array of dictionaries.
    guard let resultData = queryResult as? [[String : AnyObject]] else { throw KeychainError.unexpectedItemData }
    
    // Create a `KeychainPasswordItem` for each dictionary in the query result.
    var passwordItems = [KeychainPasswordItem]()
    for result in resultData {
      guard let account  = result[kSecAttrAccount as String] as? String else { throw KeychainError.unexpectedItemData }
      
      let passwordItem = KeychainPasswordItem(service: service, account: account, accessGroup: accessGroup)
      passwordItems.append(passwordItem)
    }
    
    return passwordItems
  }
  
  // MARK: Convenience
  
  private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
    var query = [String : AnyObject]()
    query[kSecClass as String] = kSecClassGenericPassword
    query[kSecAttrService as String] = service as AnyObject?
    
    if let account = account {
      query[kSecAttrAccount as String] = account as AnyObject?
    }
    
    if let accessGroup = accessGroup {
      query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
    }
    
    return query
  }
}

