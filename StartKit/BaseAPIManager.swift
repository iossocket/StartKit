//
//  BaseAPIManager.swift
//  StartKit
//
//  Created by XueliangZhu on 10/16/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPIManager: APIProtocol {
    
    func request(_ url: String, method: RequestMethod, encoding: RequestEncoding, params: Dictionary<String, Any>?, headers: Dictionary<String, Any>?, success: @escaping (_ result: Any) -> Void, failure: @escaping (_ error: Error) -> Void) {
        Alamofire.request(url, method: alamofireMethod(method), parameters: params, encoding: alamofireEncoding(encoding), headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    private func alamofireMethod(_ baseRequestMethod: RequestMethod) -> HTTPMethod {
        switch baseRequestMethod {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        }
    }
    
    private func alamofireEncoding(_ encoding: RequestEncoding) -> ParameterEncoding {
        switch encoding {
        case .json:
            return JSONEncoding.default
        }
    }
}
