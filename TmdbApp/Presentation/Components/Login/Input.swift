//
//  Input.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import SwiftUI

struct Input: View {
    
    var title: String
    var hint: String
    var isPassword: Bool = false
    @Binding var input: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                Spacer()
            }
            
            if !isPassword {
                TextField(title, text: $input)
                    .padding(10)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray.opacity(0.5))
                    }
            } else {
                SecureField(title, text: $input)
                    .padding(10)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray.opacity(0.5))
                        
                    }
            }
        }
    }
}
