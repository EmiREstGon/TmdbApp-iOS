//
//  ErrorResponse.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "status_code", message = "status_message"
    }
}
