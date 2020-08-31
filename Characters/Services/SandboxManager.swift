//
//  SandboxManager.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Foundation

protocol SandboxDelegate {
    
    func getText(by locale: String, success: @escaping (Response, [Character: Int]) -> (), failure: @escaping (Error) -> ())
}

class SandboxManager: SandboxDelegate {
    
    private var characters = [Character: Int]()

    func getText(by locale: String, success: @escaping (Response, [Character: Int]) -> (), failure: @escaping (Error) -> ()) {
        SandboxService.getText(by: locale, success: { [weak self] (response) in
            
            guard response.success, let text = response.data, !text.isEmpty else {
                return
            }
            
            text.forEach { (char) in
                self?.characters[char] != nil ? (self?.characters[char]! += 1) : (self?.characters[char] = 1)
            }
            
            success(response, self?.characters ?? [Character: Int]())
            
        }) { (error) in
            debugPrint(error)
        }
    }
    
}
