//
//  UserCredentials.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 7/6/23.
//

import Foundation

struct UserCredentials: Codable {
    var userName: String
    var password: String
    var requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case userName, password, requestToken = "request_token"
    }
}
