//
//  AuthManager.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import UIKit

protocol AuthenticationDelegate {
    
    func signup(with name: String, email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ())
    
    func login(with email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ())
    
    func logout(success: @escaping (Response) -> (), failure: @escaping (Error) -> ())
    
}

class AuthManager: AuthenticationDelegate {
    
    static let shared = AuthManager()
    
    private var accessToken: String? {
        didSet {
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    func getAccessToken() -> String? {
        guard let token = accessToken else {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        return token
    }
    
    func removeAccessToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }

    
    func signup(with name: String, email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ()) {
        AuthService.signup(with: name, email: email, password: password, success: { (response) in
            debugPrint(response)
            if let token = response.data?.accessToken {
                AuthManager.shared.accessToken = token
            }
            success(response)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.setRootView(storyboard.instantiateViewController(withIdentifier: "HomeNavVC"))
        }) { (error) in
            debugPrint(error)
        }
    }
    
    func login(with email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ()) {
        AuthService.login(with: email, password: password, success: { (response) in
            debugPrint(response)
            if let token = response.data?.accessToken {
                AuthManager.shared.accessToken = token
            }
            success(response)
        }) { (error) in
            debugPrint(error)
        }
    }
    
    func logout(success: @escaping (Response) -> (), failure: @escaping (Error) -> ()) {
        AuthService.logout(success: { (response) in
            debugPrint(response)
            AuthManager.shared.removeAccessToken()
            success(response)
        }) { (error) in
            debugPrint(error)
        }
    }

    
}
