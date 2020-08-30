//
//  AuthModel.swift
//  Characters
//
//  Created by Serhii Kovtunenko on 30.08.2020.
//  Copyright © 2020 Wonderland. All rights reserved.
//

import Foundation

struct Login: Encodable {
    let email: String
    let password: String
}

struct Signup: Encodable {
    let name: String
    let email: String
    let password: String
}

struct Response: Decodable {
    let success: Bool
    let data: String?
    let errors: APIErrors?
}

struct ResponseUser: Decodable {
    let success: Bool
    let data: User?
    let errors: APIErrors?
}

struct User: Decodable {
    let uid: Int
    let name, email, accessToken: String
    let role, status, createdAt, updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case uid, name, email
        case accessToken = "access_token"
        case role, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct APIError: Decodable {
    let name: String?
    let message: String
    let code: Int?
    let status: Int?
    let field: String?
}

typealias APIErrors = [APIError]
