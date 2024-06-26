//
//  MovieModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation
import SwiftUI

// MARK: - MovieModel
struct MovieModel: Identifiable, Codable {
    var id: String? = UUID().uuidString
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    let adult: Bool
    let backdropPath: String
    let fullPosterPath: String?
    let fullBackdropPath: String?
    let genreIDS: [Int]
    let movieID: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    var imageData: Image?
    var backdropData: Image?
    var detailsImageList: [Image]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case movieID = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video, fullPosterPath, fullBackdropPath
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    func updatePostersPath(newPathPoster: String, newPathBackdrop: String) -> Movie {
        Movie(adult: adult, backdropPath: backdropPath, fullPosterPath: newPathPoster, fullBackdropPath: newPathBackdrop, genreIDS: genreIDS, movieID: movieID, originalLanguage: originalLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount)
    }

}

enum OriginalLanguage: String, Codable {
    case bn = "bn"
    case en = "en"
    case fr = "fr"
    case ko = "ko"
    case pl = "pl"
    case es = "es"
    case zh = "zh"
    case ja = "ja"
    case it = "it"
    case th = "th"
    case pt = "pt"
    case af = "af"
    case nl = "nl"
    case de = "de"
    case tr = "tr"
    case hi = "hi"
    case cn = "cn"
    case tl = "tl"
}
