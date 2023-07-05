//
//  GridViewModel.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 28/6/23.
//

import Foundation

class GridViewModel: ObservableObject {
    @Published var gridModel: [Result] = []
    @Published var isEnd: Bool = false
    
    let enpoint: String
    var params: [String : Any]
    let type: RowType
    var page: Int = 1
    
    init(enpoint: String, params: [String : Any], type: RowType) {
        self.enpoint = enpoint
        self.params = params
        self.type = type
        
        loadGrid()
    }
    
    func loadGrid() {
        params["page"] = page
        
        if type == .media {
            ApiService.get(endPoint: enpoint, parameters: params) { (details: ResultList) in
                self.gridModel.append(contentsOf: details.result)
                self.page += 1
                self.isEnd = details.page >= details.totalPage
            }
        }
    }
    
    func next(result: Result) {
        if gridModel.count >= 4, result == gridModel[gridModel.count - 3] {
            loadGrid()
        }
    }
}
