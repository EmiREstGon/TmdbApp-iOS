//
//  StringHelper.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 21/6/23.
//

import Foundation

class StringHelper{
    
    func convertDateString(_ inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: inputDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let outputDate = dateFormatter.string(from: date)
        
        return outputDate
    }
    
    func extractYearFromString(_ inputDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: inputDate) else {
            return nil
        }
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        return String(year)
    }
}
