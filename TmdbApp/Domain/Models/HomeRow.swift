//
//  HomeRow.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 12/6/23.
//

import Foundation

struct HomeRow: Identifiable {
    var id: UUID = UUID()
    var title: String
    var list: ResultList
    var endPoint: String
    var params: [String: Any]
}
