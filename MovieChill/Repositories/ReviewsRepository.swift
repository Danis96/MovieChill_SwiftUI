//
//  ReviewsRepository.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation
import SwiftUI
import Combine

struct ReviewsRepository {
    
   private var networkService = NetworkService()
    
    
    func getReviews<T: Decodable>(id: Int, for tv: Bool, type: T.Type) async throws -> ReviewsResultModel {
        
        var urlString: String = ""
        
        if tv {
            urlString = ApiPaths().getValue(api: .reviews, concatValue: "tv", concatValue2: String(id))
        } else {
            urlString = ApiPaths().getValue(api: .reviews, concatValue: "movie", concatValue2: String(id))
        }
        
        do {
            let data = try await networkService.fetchData(from: urlString,
                                                          as: ReviewsResultModel.self,
                                                          queryItems: queryItems,
                                                          headers: ApiHeaders().getValue(type: .json_token))
            return data
        } catch  {
            throw error
        }
    }
    
    let queryItems: [URLQueryItem] = [
      URLQueryItem(name: "language", value: "en-US"),
      URLQueryItem(name: "page", value: "1"),
    ]
    
}
