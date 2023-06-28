//
//  GridView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 28/6/23.
//

import SwiftUI

struct GridView: View {
    @StateObject var gridViewModel: GridViewModel

    init() {
        let viewModel = GridViewModel()
        _gridViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Grid")
        Grid(alignment: .leading) {
            ForEach(gridViewModel.rows) { row in
                ImageCardRow(title: row.title, imageCards: row.list.result, endPoint: row.endPoint, params: row.params)
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
