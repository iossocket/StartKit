//
//  LocalStorage.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

protocol LocalStorage {
  func save<T: DBMapper>(object: T)
  func queryOne<T: DBMapper>(with object: T, completion: @escaping (T.Domain) -> ())
}
