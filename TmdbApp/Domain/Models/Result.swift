//
//  Result.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 5/6/23.
//

import Foundation

enum Results: String {
    case tv, movie, person
}

struct Result: Identifiable, Hashable {
    let uuid = UUID()
    let id: Int?
    let title: String
    let subtitle: String?
    let character: String?
    let image: String
    let type: Results
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}
