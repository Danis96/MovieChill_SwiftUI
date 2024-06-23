//
//  MovieModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation


// MARK: - MovieModel
struct MovieModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages
        case totalResults
    }
}

// MARK: - Movie
struct Movie: Identifiable, Codable, Equatable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath
        case genreIDS
        case id
        case originalLanguage
        case originalTitle
        case overview, popularity
        case posterPath
        case releaseDate
        case title, video
        case voteAverage
        case voteCount
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

enum OriginalLanguage: String, Codable {
    case bn = "bn"
    case en = "en"
    case fr = "fr"
    case ko = "ko"
}
