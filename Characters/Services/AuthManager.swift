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
    
    var accessToken: String? {
        
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
        
        get {
            UserDefaults.standard.string(forKey: "accessToken")
        }
        
    }
    
    func signup(with name: String, email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ()) {
        AuthService.signup(with: name, email: email, password: password, success: { [weak self] (response) in
            debugPrint(response)
            if let token = response.data?.accessToken {
                self?.accessToken = token
            }
            success(response)
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.setRootView(storyboard.instantiateViewController(withIdentifier: "HomeNavVC"))
        }) { (error) in
            debugPrint(error)
        }
    }
    
    func login(with email: String, password: String, success: @escaping (ResponseUser) -> (), failure: @escaping (Error) -> ()) {
        AuthService.login(with: email, password: password, success: { [weak self] (response) in
            debugPrint(response)
            if let token = response.data?.accessToken {
                self?.accessToken = token
            }
            success(response)
        }) { (error) in
            debugPrint(error)
        }
    }
    
    func logout(success: @escaping (Response) -> (), failure: @escaping (Error) -> ()) {
        AuthService.logout(success: { [weak self] (response) in
            debugPrint(response)
            self?.accessToken = nil
            success(response)
        }) { (error) in
            debugPrint(error)
        }
    }

    
}
