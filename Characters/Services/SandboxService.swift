//
//  SandboxService.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 31.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Alamofire

class SandboxService {
    
    static func getText(by locale: String, success: @escaping (Response) -> (), failure: @escaping (Error) -> ()) {
        let params = Locale(locale: locale)
        Network.request(with: API.getText, parameters: params, success: success, failure: failure)
    }
}
