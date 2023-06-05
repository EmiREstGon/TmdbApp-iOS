//
//  LoginButton.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import SwiftUI

struct LoginButton: View {
    
    var onAction: (() -> Void?)? = nil
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            Button(action: {
                guard let action = onAction else {
                    return
                }
                
                action()
                
            }, label: {
                VStack {
                    if !loginViewModel.isLogging {
                    Text("Login")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    } else {
                        ProgressView()
                            .tint(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(loginViewModel.validate() ? Color.green.opacity(0.5) : Color.green)
                .cornerRadius(10)
            })
            .disabled(loginViewModel.validate())
        }
    }
}

struct LoginButton_Preview: PreviewProvider {
    @StateObject static var loginViewModel: LoginViewModel = LoginViewModel()
    
    static var previews: some View {
        LoginButton(loginViewModel: loginViewModel)
    }
}
