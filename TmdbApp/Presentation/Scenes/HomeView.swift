//
//  HomeView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 12/6/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
    
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
