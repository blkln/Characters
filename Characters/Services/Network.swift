//
//  Network.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 30.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Alamofire

class Network {
    
    static var session: Session = {
        Session(configuration: URLSessionConfiguration.af.default, interceptor: RequestInterceptor())
    }()
    
    
}

extension Network {
    
    class func request<T: Decodable, Parameters: Encodable>(with url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, success: ((T) -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        session.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                #if DEBUG
                debugPrint(response)
                debugPrint(response.request as Any)
                #endif
                if (response.error == nil), let data = response.data {
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        success?(response)
                    } catch {
                        failure?(error)
                    }
                } else {
                    guard let error = response.error else {
                        failure?("Something went wrong" as! Error)
                        return
                    }
                    failure?(error)
                }
        }
    }
    
}

final class RequestInterceptor: Alamofire.RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        /*
        if urlRequest.url?.absoluteString.hasPrefix(API.auth) == true {
            /// If the request does not require authentication, we can directly return it as unmodified.
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest

        guard let token = UserData.shared.getAuth()?.access else {
            return completion(.success(urlRequest))
        }
        /// Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
*/
        completion(.success(urlRequest))
    }

}
