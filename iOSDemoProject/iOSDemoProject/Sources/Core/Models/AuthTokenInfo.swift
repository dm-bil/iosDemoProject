//
//  AuthTokenInfo.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 02.06.2023.
//

import Foundation

struct AuthTokenInfo: Equatable, Codable {
    let accessToken: String
    let expiresInTimestamp: Int
    let tokenType: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresInTimestamp = "expires_in"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
    }
}
