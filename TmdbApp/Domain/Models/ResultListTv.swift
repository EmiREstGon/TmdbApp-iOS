//
//  ResultListTv.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 13/6/23.
//

import Foundation

struct TvResultList: Codable {
    var page: Int?
    var totalPage: Int
    var totalResults: Int
    var _results: [TvResult]
    
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

struct TvResult: Codable {
    var backdropPath: String?
    var firstAirDate: String?
    var genreIds: [Int]
    var id: Int
    var name: String?
    var originCountry: [String]?
    var originalLanguage: String
    var originalName: String?
    var overview: String
    var popularity: Double
    var posterPath: String
    var voteAverage: Double?
    var voteCount: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
        case id
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "orignal_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var result: Result {
        .init(id: id, title: name ?? "", subtitle: firstAirDate, image: posterPath, type: .tv)
    }
}
