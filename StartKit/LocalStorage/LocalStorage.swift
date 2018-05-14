//
//  LocalStorage.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/13.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation
import RxSwift

protocol LocalStorage {
  func save<M: DBMapper>(object: M.Domain, mapper: M)
  func queryOne<M: DBMapper>(withMapper mapper: M) -> Observable<M.Domain?>
  func deleteAllObjects(for entityName: String)
}
