//
//  RepoAPIManager.swift
//  StartKit
//
//  Created by XueliangZhu on 10/28/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import ObjectMapper

enum RepoApiError: Error {
    case fetchFailed
}

enum RepoResult<T> {
    case success(value: T)
    case failure(error: RepoApiError)
}

class RepoAPIManager {
    private let baseApiManager: APIProtocol
    private let BASEURL = "https://api.github.com"
    
    init(baseApiManager: APIProtocol = BaseAPIManager()) {
        self.baseApiManager = baseApiManager
    }
    
    func fetchAllRepos(token: String, handler: @escaping (RepoResult<Array<Repo>>) -> Void) {
        let headers = ["Authorization": "token \(token)"]
        baseApiManager.request(BASEURL + "/user/repos", method: .get, encoding: .json, params: nil, headers: headers, success: { result in
            guard let repoList = result as? Array<Any> else {
                handler(.failure(error: .fetchFailed))
                return
            }
            
            var repos = Array<Repo>()
            for repo in repoList {
                guard let item = Mapper<Repo>().map(JSONObject: repo) else {
                    continue
                }
                repos.append(item)
            }
            handler(.success(value: repos))
        }) { error in
            handler(.failure(error: .fetchFailed))
        }
    }
    
    func fetchRepo(name: String, user: String, handler: @escaping (Any) -> Void) {
        baseApiManager.request(BASEURL + "/repos/\(user)/\(name)", method: .get, encoding: .json, params: nil, headers: nil, success: { result in
            print(result)
        }) { error in
            print(error)
        }
    }
}
