//
//  UserService.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import Foundation
import KeychainAccess
import Alamofire

class UserService: ObservableObject {
    private var storage: Keychain = .init(service: "com.emilio.TmdbApp")
    static var sharedInstance: UserService = .init()
    @Published var sessionId: String? = nil
    @Published var isLogged: Bool = false
    
    init() {
        loadSessionId()
    }
    
    var hasSessionId: Bool {
        guard let _ = try? storage.get("session_id") else {
            return false
        }
        
        return true
    }
    
    func loadSessionId() {
        if let sessionValue = try? storage.get("session_id") {
            self.sessionId = sessionValue
            isLogged = hasSessionId
        } else {
            sessionId = nil
            isLogged = hasSessionId
        }
    }
    
    func authenticate(username: String, password: String, errorCallback: ((ErrorResponse?) -> Void)? = nil, successCallback: (() -> Void)? = nil) {
        newToken { token in
            let userCredentials: UserCredentials = .init(username: username, password: password, requestToken: token.requestToken)
            
            ApiService.post(endPoint: "authentication/token/validate_with_login", body: userCredentials, callBack: { (responseToken: Token) in
                if token.success {
                    self.newSession(requestToken: responseToken.requestToken, errorCallback: errorCallback)
                }
            }, errorCallback: errorCallback)
        }
    }
    
    private func newToken(done: @escaping (Token) -> Void) {
        ApiService.get(endPoint: "authentication/token/new") { (token: Token) in
            if token.success {
                done(token)
            }
        }
    }
    
    func newSession(requestToken: String, errorCallback: ((ErrorResponse?) -> Void)? = nil, successCallback: (() -> Void)? = nil) {
        let tokenCredentials: TokenCredential = .init(requestToken: requestToken)

        ApiService.post(endPoint: "authentication/session/new", body: tokenCredentials, callBack: { (session: Session) in
            if session.success {
                do {
                    try self.storage.set(session.sessionId, key: "session_id")
                    self.loadSessionId()
                    successCallback?()
                } catch(let error) {
                    print(error.localizedDescription)
                }
            }
        }, errorCallback: errorCallback)
    }
    
    func unauthenticate() {
        let sessionCredential: SessionCredential = .init(sessionId: sessionId ?? "")

        ApiService.delete(endPoint: "authentication/session", body: sessionCredential, callBack: { (logoutResponse: LogoutResponse) in
            if logoutResponse.success {
                do {
                    try self.storage.remove("session_id")
                    
                    self.loadSessionId()
                } catch(let error) {
                    print(error.localizedDescription)
                }
            }
        })
    }
}
