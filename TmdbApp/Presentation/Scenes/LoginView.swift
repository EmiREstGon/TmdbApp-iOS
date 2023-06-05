//
//  LoginView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            LoginThumbnail()
            
            Spacer()
            
            Input(title: "Username", hint: "Username", input: $loginViewModel.username)
            Input(title: "Password", hint: "Password", isPassword: true, input: $loginViewModel.password)
            
            Spacer()
            
            LoginButton(onAction: onCallLogin, loginViewModel: loginViewModel)
        }
        .padding(.horizontal)
    }
}

extension LoginView {
    func onCallLogin() {
        loginViewModel.login()
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
