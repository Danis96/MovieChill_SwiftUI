//
//  ApiPaths.swift
//  SWAPI
//
//  Created by Danis Preldzic on 10. 6. 2024..
//

import Foundation

enum APIS {
   case movies
   case posters
   case tvShows
   case movieCredits
   case tvCredits
   case reviews
   case rating
   case certifications
}

class ApiPaths {
    
    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let posterUrl: String = "https://image.tmdb.org/t/p/original"
    
    func getValue(api: APIS, concatValue: String = "", concatValue2: String = "") -> String {
        switch api {
        case .movies:
            return self.baseUrl + "discover/movie"
        case .posters:
            return self.posterUrl + concatValue
        case .tvShows:
            return self.baseUrl + "discover/tv"
        case .movieCredits:
            return self.baseUrl + "movie/\(concatValue)/credits"
        case .tvCredits:
            return self.baseUrl + "tv/\(concatValue)/credits"
        case .reviews:
            return self.baseUrl + "\(concatValue)/\(concatValue2)/reviews"
        case .rating:
            return self.baseUrl + "\(concatValue)/\(concatValue2)/rating"
        case .certifications:
            return self.baseUrl + "certification/\(concatValue)/list"
        }
    }
}
