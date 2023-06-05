//
//  Token.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 7/6/23.
//

import Foundation

struct Token: Codable {
    var success: Bool
    var expiresAt: String
    var requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success, expiresAt = "expires_at", requestToken = "request_token"
    }
}

struct TokenCredential: Codable {
    var requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}

struct SessionCredential: Codable {
    var sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}

struct Session: Codable {
    var success: Bool
    var sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success, sessionId = "session_id"
    }
}

struct LogoutResponse: Codable {
    var success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success
    }
}

struct UserCredentials: Codable {
    var username: String
    var password: String
    var requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username, password, requestToken = "request_token"
    }
}
