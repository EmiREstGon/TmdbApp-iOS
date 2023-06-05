//
//  MediaDetailsViewModel.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 14/6/23.
//

import Foundation

class MediaDetailsViewModel: ObservableObject {
    @Published var mediaDetails: MediaDetails? = nil
    
    let id: Int
    let type: Results
    
    init(id: Int, type: Results) {
        self.id = id
        self.type = type
        
        loadDetails()
    }
    
    func loadDetails(){
        var param: [String: Any] = [:]
        
        param = ["append_to_response" : "similar,recommendations,credits,videos"]
        
        if type == .movie {
            ApiService.get(endPoint: "\(type)/\(id)", parameters: param) { (details: MovieDetails) in
                self.mediaDetails = details
            }
        }
        
        if type == .tv {
            ApiService.get(endPoint: "\(type)/\(id)", parameters: param) { (details: TVDetails) in
                self.mediaDetails = details
            }
        }
    }
}
