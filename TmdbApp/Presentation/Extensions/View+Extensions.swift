//
//  View+Extensions.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 14/6/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func toDetailsView(result: Result) -> some View {
        NavigationLink(destination: destination(result: result)) {
            self
        }
            .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func destination(result: Result) -> some View {
        switch result.type {
            case .movie, .tv:
                MediaDetailsView(id: result.id ?? 0, type: result.type).navigationTitle(result.title)
            case .person:
                PersonDetailsView(id: result.id ?? 0).navigationTitle(result.title)
        }
    }
}
