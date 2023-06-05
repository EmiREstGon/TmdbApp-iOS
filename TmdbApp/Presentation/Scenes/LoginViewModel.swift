//
//  Login.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var error: ErrorResponse? = nil
    @Published var isLogging: Bool = false
    
    func login() {
        isLogging = true
        
        UserService.sharedInstance.authenticate(username: username, password: password, errorCallback: { errorResponse in
            self.isLogging = false
            self.error = errorResponse
        }, successCallback: {
            self.isLogging = false
        })
    }
    
    func validate() -> Bool {
        return username.isEmpty || password.isEmpty
    }
}
