//
//  TVModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation
import SwiftUI

// MARK: - TVModel
struct TVModelResults: Decodable {
    let page: Int
    let results: [TVModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TVModel: Identifiable, Decodable {
    let adult: Bool
    let backdropPath: String
    let fullPosterPath: String?
    let fullBackdropPath: String?
    let genreIDS: [Int]
    var id: String = UUID().uuidString
    let televisionID: Int
    let originCountry: [String]
    let originalLanguage: OriginalLanguage
    let originalName, overview: String
    let popularity: Double
    let posterPath, firstAirDate, name: String
    let voteAverage: Double
    let voteCount: Int
    var imageData: Image?
    var backdropData: Image?
    var detailsImageList: [Image]?
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case televisionID = "id"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name, fullPosterPath, fullBackdropPath
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
       
    }
    
    func updatePostersPath(newPathPoster: String, newPathBackdrop: String) -> TVModel {
        TVModel(adult: adult, backdropPath: backdropPath, fullPosterPath: newPathPoster, fullBackdropPath: newPathBackdrop, genreIDS: genreIDS, id: id, televisionID: televisionID, originCountry: originCountry, originalLanguage: originalLanguage, originalName: originalName, overview: overview, popularity: popularity, posterPath: posterPath, firstAirDate: firstAirDate, name: name, voteAverage: voteAverage, voteCount: voteCount, imageData: imageData, backdropData: backdropData, detailsImageList: detailsImageList)
    }
    
    static func == (lhs: TVModel, rhs: TVModel) -> Bool {
        lhs.id == rhs.id
    }
}
    
