//
//  ContentView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userService: UserService = .sharedInstance
    
    var body: some View {
        NavigationView {
            if userService.isLogged {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
