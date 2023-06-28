//
//  HomeView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 12/6/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    @State private var isButtonEnabled = true
    
    var body: some View {
        ScrollView {
            ForEach(homeViewModel.rows) { row in
                ImageCardRow(title: row.title, imageCards: row.list.result, endPoint: row.endPoint, params: row.params)
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("TMDB")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                logout
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                refresh
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                search
            }
        }
        .onAppear {
            if homeViewModel.rows.isEmpty {
                homeViewModel.fetchMovieList()
            }
        }
    }
    
    var logout: some View {  // Logout Button
        Button(action: {
            homeViewModel.logout()
        }) {
            Text("Logout")
            SwiftUI.Image(systemName: "door.left.hand.open")
        }
    }
    
    var search: some View {  // Search Button
        Button(action: {
            
        }) {
            SwiftUI.Image(systemName: "magnifyingglass")
        }
    }
    
    var refresh: some View {  // Refresh Button
        Button(action: {
            isButtonEnabled = false     // Deshabilitar el botón al hacer click
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isButtonEnabled = true  // Habilitar el botón después de 3 segundos
            }
            
            homeViewModel.fetchMovieList()
        }) {
            SwiftUI.Image(systemName: "arrow.triangle.2.circlepath")
        }
        .disabled(!isButtonEnabled) // Deshabilitar el botón si isButtonEnabled es falso
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
