//
//  ResultList.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 12/6/23.
//

import Foundation
import CodableX

struct ResultList: Codable {
    var page: Int
    var totalPage: Int
    var totalResults: Int
    var _results: [MediaResult]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPage = "total_pages"
        case totalResults = "total_results"
        case _results = "results"
    }
    
    var result: [Result] {
        _results.map { $0.result }
    }
}

struct MediaResult: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Double?
    
    var firstAirDate: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
        case firstAirDate = "first_air_date"
        case name
    }
    
    var result: Result {
        .init(id: id ?? 0, title: (title ?? name) ?? "", subtitle: (releaseDate ?? firstAirDate) ?? "", character: "", image: posterPath ?? "", type: (title != nil) ? .movie : .tv)
    }
}
