//
//  GitHubLoginInteractor.swift
//  StartKit
//
//  Created by Xin Guo  on 2018/5/10.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import Foundation

protocol GitHubLoginInteractorProtocol {
  func login(withEmailOrUsername: String, password: String)
}
