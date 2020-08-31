//
//  AuthService.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 30.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Alamofire

class AuthService {
    
    static func login(with email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ()) {
        let params = Login(email: email, password: password)
        Network.request(with: API.login, method: .post, parameters: params, success: success, failure: failure)
    }
    
    static func logout(success: @escaping (Response) -> (), failure: @escaping (Error) -> ()) {
        Network.request(with: API.logout, method: .post, parameters: ["": ""], success: success, failure: failure)
    }
    
    static func signup(with name: String, email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ()) {
        let params = Signup(name: name, email: email, password: password)
        Network.request(with: API.signup, method: .post, parameters: params, encoder: JSONParameterEncoder.default, success: success, failure: failure)
    }

}
