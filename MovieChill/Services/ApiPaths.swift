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
}

class ApiPaths {
    
    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let posterUrl: String = "https://image.tmdb.org/t/p/original"
    
    func getValue(api: APIS, concatValue: String = "") -> String {
        switch api {
        case .movies:
            return self.baseUrl + "discover/movie"
        case .posters:
            return self.posterUrl + concatValue
        case .tvShows:
            return self.baseUrl + "discover/tv"
        case .movieCredits:
            return self.baseUrl + "movie/\(concatValue)/credits"
        }
    }
}
