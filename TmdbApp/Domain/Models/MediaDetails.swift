//
//  MediaDetails.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 14/6/23.
//

import Foundation
import CodableX

protocol MediaDetails: AnyCodable {
    var details: DetailsWrapper { get }
}

struct DetailsWrapper: Codable {
    let id: Int
    let title: String
    let genres: [Genre]
    let backdrop: String?
    let poster: String?
    let overview: String
    let date: String
    let tagline: String
    let status: String?
    var recommendations: ResultList?
    var similar: ResultList?
    var credits: Credits?
    var seasons: [Season]?
    var videos: Videos
}

struct MediaDetailsResult: AnyCodable {
    @AnyValuable<MediaOptions> var _details: AnyValue
}


extension AnyValue {
    var details: MediaDetails? {
        value as? MediaDetails
    }
}

public struct MediaOptions: OptionConfigurable {
    public static var options: [Option] = [
        .init(MovieDetails.self),
        .init(TVDetails.self),
    ]
}

// MARK: - MovieDetails

struct MovieDetails: MediaDetails {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    @Defaultable var overview: String
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    @Defaultable var tagline: String
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let similar: ResultList?
    let recommendations: ResultList?
    let credits: Credits?
    var videos: Videos
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case similar, recommendations, credits, videos
    }
    
    var details: DetailsWrapper {
        .init(
            id: id,
            title: title,
            genres: genres ?? [],
            backdrop: backdropPath,
            poster: posterPath,
            overview: overview,
            date: releaseDate ?? "",
            tagline: tagline,
            status: status,
            recommendations: recommendations,
            similar: similar,
            credits: credits,
            seasons: nil,
            videos: videos
        )
    }
}

// MARK: - TVDetails
struct TVDetails: MediaDetails {
    let adult: Bool?
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: Episode?
    let name: String
    let nextEpisodeToAir: Episode?
    let networks: [Network]?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Network]?
    let productionCountries: [ProductionCountry]?
    let seasons: [Season]?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?
    let similar, recommendations: ResultList?
    let credits: Credits?
    var videos: Videos

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case similar, recommendations, credits, videos
    }

    var details: DetailsWrapper {
        .init(id: id, title: name, genres: genres ?? [], backdrop: backdropPath, poster: posterPath, overview: overview ?? "", date: firstAirDate ?? "", tagline: tagline ?? "", status: status, recommendations: recommendations, similar: similar, credits: credits ?? Credits(cast: [], crew: []), seasons: seasons, videos: videos)
    }
}

// MARK: - PeopleDetails

struct PersonDetails: Codable {
    let adult: Bool?
    let gender: Int
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let placeOfBirth: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    @Defaultable var order: Int
    let department: String?
    let job: String?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let images: PersonImages?
    @Nullable var combinedCredits: CombinedCredits?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
        case biography
        case birthday
        case deathday
        case images
        case combinedCredits = "combined_credits"
    }

    var result: Result {
    .init(
        id: id,
        title: name ?? "",
        subtitle:"✩ " + (popularity?.description ?? ""),
        character: character,
        image: profilePath ?? "",
        type: .person)
    }
}

struct BelongsToCollection: AnyCodable {
    var id: Int?
    var name: String?
    var posterPath:String?
    var backdropPatch:String?
}

// MARK: - Credits

struct Credits: Codable {
    let cast, crew: [PersonDetails]?
    var castResults: [Result] { cast?.sorted (by: { $0.order < $1.order })[0..<min(15, cast?.count ?? 0)].map {$0.result} ?? [] }
}

// MARK: - Genre

struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry

struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - Recommendations

struct Recommendations: Codable {
    let page: Int?
    let results: [MediaResult]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - SpokenLanguage

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

// MARK: - Videos

struct Videos: Codable {
    let results: [VideosResult]
}

// MARK: - CreatedBy

struct CreatedBy: Codable {
    let id: Int?
    let creditID, name: String?
    let gender: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}

// MARK: - LastEpisodeToAir

struct Episode: Codable {
    let id: Int?
    let name, overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let airDate: String?
    let episodeNumber: Int?
    let productionCode: String?
    let runtime, seasonNumber, showID: Int?
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}

// MARK: - Network

struct Network: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - VideosResult

struct VideosResult: Codable {
    let name, key: String?
    let site: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name, key, site, id
    }
}

// MARK: - Season

struct Season: Codable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - PersonImages

struct PersonImages: Codable {
    let id: Int?
    let profiles: [Profile]?
}

// MARK: - Profile

struct Profile: Codable {
    let filePath: String?

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}

struct CombinedCredits: Codable {
    var _cast: [MediaResult]

    enum CodingKeys: String, CodingKey {
        case _cast = "cast"
    }

    var cast: [Result] {
        _cast.map { $0.result }
    }
}
