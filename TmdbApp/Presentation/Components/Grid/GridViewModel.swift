//
//  GridViewModel.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 28/6/23.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var rows: [HomeRow] = []
    
    var endpoints: [Endpoint] = [
        Endpoint(path: "movie/popular", title: "Popular Movies"),
        Endpoint(path: "movie/top_rated", title: "Top Rated Movies"),
        Endpoint(path: "movie/upcoming", title: "Upcoming Movies"),
        Endpoint(path: "tv/airing_today", title: "Airing TV Shows Today"),
        Endpoint(path: "tv/popular", title: "Popular TV Shows"),
        Endpoint(path: "tv/top_rated", title: "Top Rated TV Shows"),
        Endpoint(path: "trending/all/week", title: "Trending Now")
    ]
    
    func fetchContentList() {
        for endpoint in endpoints {
            ApiService.get(endPoint: endpoint.path) { (result: ResultList) in
                self.rows.append(.init(title: endpoint.title, list: result, endPoint: endpoint.path, params: endpoint.params))
            }
        }
    }
}
