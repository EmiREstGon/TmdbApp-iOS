//
//  PersonDetailViewModel.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 21/6/23.
//

import SwiftUI

class PersonDetailsViewModel: ObservableObject {
    @Published var castDetails: PersonDetails? = nil
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        
        loadDetails()
    }
    
    func loadDetails(){
        var param: [String: Any] = [:]
        
        param = ["append_to_response" : "combined_credits,images"]

        ApiService.get(endPoint: "person/\(id)", parameters: param) { (details: PersonDetails) in
            self.castDetails = details
        }
    }
}
