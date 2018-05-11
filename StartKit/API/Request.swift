//
//  Request.swift
//  StartKit
//
//  Created by XueliangZhu on 5/2/18.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
  case get
  case post
  case delete
  case put
}

protocol Request {
  var path: String { get }
  
  var method: HTTPMethod { get }
  var parameter: [String: Any] { get }
  var headers: [String: String]? { get }
  var encoding: ParameterEncoding? { get }
  
  associatedtype Response: Decodable
}

extension Data {
  func jsonDataMapModel<T: Decodable>(_ type: T.Type) -> T? {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(T.self, from: self)
    } catch {
      return nil
    }
  }
}
