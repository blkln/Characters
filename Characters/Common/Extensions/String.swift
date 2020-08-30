//
//  String.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 30.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Foundation

extension String
{
    func APIBaseUrl() -> String {
        return API.baseUrl + self
    }
}
