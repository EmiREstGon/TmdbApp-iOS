//
//  GridView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 28/6/23.
//

import SwiftUI

struct GridView: View {
    @StateObject private var gridViewModel: GridViewModel
    
    init(endpoint: String, params: [String : Any], type: RowType) {
        self._gridViewModel = StateObject<GridViewModel>(wrappedValue: .init(enpoint: endpoint, params: params, type: type))
    }
    
    let gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            Section(footer: footer()) {
                LazyVGrid(columns: gridLayout, spacing: 10) {
                    ForEach(gridViewModel.gridModel) { result in
                        ImageCard(result: result)
                            .toDetailsView(result: result)
                            .onAppear {
                                if !gridViewModel.isEnd {
                                    DispatchQueue.global(qos: .userInitiated).async {
                                        gridViewModel.next(result: result)
                                    }
                                }
                            }
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func footer() -> some View {
        if gridViewModel.isEnd {
            Text("Fin")
        } else {
            ProgressView()
        }
    }
}

//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView()
//    }
//}
