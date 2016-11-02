//
//  UserAPIManager.swift
//  StartKit
//
//  Created by XueliangZhu on 10/16/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserApiError: Error {
    case loginFailed
    case logoutFailed
    case profileFailed
}

enum UserResult<T> {
    case success(value: T)
    case failure(error: UserApiError)
}

class UserAPIManager {
    private let baseApiManager: APIProtocol
    private let BASEURL = "https://api.github.com"
    
    init(baseApiManager: APIProtocol = BaseAPIManager()) {
        self.baseApiManager = baseApiManager
    }
    
    func login(userName: String, password: String, handler: @escaping (UserResult<(token: String, id: String)>) -> Void) {
        let credentialData = "\(userName):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        let params: Dictionary<String, Any> = ["scopes": ["repo", "user"], "note": "GitHubDemo"]
        baseApiManager.request(BASEURL + "/authorizations", method: .post, encoding: .json, params: params, headers: headers, success: { result in
            print(result)
            guard let dict = result as? Dictionary<String, Any>,
                  let token = dict["token"] as? String,
                  let id = dict["id"] as? Int else {
                handler(.failure(error: .loginFailed))
                return
            }
            handler(.success(value: (token, "\(id)")))
        }) { error in
            handler(.failure(error: .loginFailed))
        }
    }
    
    func logout(userName: String, password: String, id: String, handler: @escaping (UserResult<Void>) -> Void) {
        let credentialData = "\(userName):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        baseApiManager.request(BASEURL + "/authorizations/\(id)", method: .delete, encoding: .url, params: [:], headers: headers, success: { result in
            handler(.success(value: ()))
        }) { error in
            handler(.failure(error: .logoutFailed))
        }
    }
    
    func profile(token: String, handler: @escaping (UserResult<User>) -> Void) {
        let headers = ["Authorization": "token \(token)"]
        baseApiManager.request(BASEURL + "/user", method: .get, encoding: .url, params: nil, headers: headers, success: { result in
            guard let user = Mapper<User>().map(JSONObject: result) else {
                handler(.failure(error: .profileFailed))
                return
            }
            handler(.success(value: user))
        }) { error in
            handler(.failure(error: .profileFailed))
        }
    }
}
