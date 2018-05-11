//
//  RxClient.swift
//  StartKit
//
//  Created by XueliangZhu on 5/2/18.
//  Copyright © 2018 ThoughtWorks. All rights reserved.
//

import RxSwift
import RxCocoa

enum APIError: Error {
  case requestError
  case httpError(code: String, message: String)
  case authenticationError(message: String)
  case parseError
  case networkError
}

protocol RxClient {
  func send<T: Request>(_ r: T) -> Observable<T.Response>
  var host: String { get }
}

struct RxURLSessionClient: RxClient {
  var host: String {
    return "https://api.github.com"
  }
  
  func send<T: Request>(_ r: T) -> Observable<T.Response> {
    guard let request = createRequest(r, host: host) else {
      return Observable.error(APIError.requestError)
    }
    
    if (Reachability.forInternetConnection()?.currentReachabilityStatus() == NotReachable) {
      return Observable.error(APIError.networkError)
    }
    return URLSession.shared.rx.response(request: request).flatMap { (response, data) -> Observable<T.Response> in
      if 200 ..< 300 ~= response.statusCode {
        print(HTTPCookieStorage.shared.cookies ?? "")
        
        if let result = data.jsonDataMapModel(T.Response.self) {
          return Observable.just(result)
        } else {
          return Observable.error(APIError.parseError)
        }
      } else {
        let errorCode = self.getErrorMessageFromData(data).code
        let errorMessage = self.getErrorMessageFromData(data).message
        return Observable.error(APIError.httpError(code: errorCode, message: errorMessage))
      }
    }
  }
  
  private func createRequest<T: Request>(_ r: T, host: String) -> URLRequest? {
    guard let request = requestWithHeader(host.appending(r.path), method: r.method, headers: r.headers) else {
      return nil
    }
    
    var encoding: ParameterEncoding
    if let requestEncoding = r.encoding {
      encoding = requestEncoding
    } else {
      switch r.method {
      case .post, .put:
        encoding = .json
      case .get, .delete:
        encoding = .url
      }
    }
    
    let encodedRequest = encoding.encode(request, parameters: r.parameter)
    return encodedRequest
  }
  
  private func requestWithHeader(_ url: String, method: HTTPMethod, headers: [String: String]? = nil) -> URLRequest? {
    guard let url = URL(string: url) else {
      return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.timeoutInterval = 15
    if let headers = headers {
      for (headerField, headerValue) in headers {
        request.setValue(headerValue, forHTTPHeaderField: headerField)
      }
    }
    request.httpShouldHandleCookies = true
    return request
  }
  
  private func getErrorMessageFromData(_ data: Data) -> (code: String, message: String) {
    guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
      return ("", "")
    }
    let message = (obj?["message"] as? String) ?? ""
    let code = (obj?["code"] as? String) ?? ""
    return (code, message)
  }
}
