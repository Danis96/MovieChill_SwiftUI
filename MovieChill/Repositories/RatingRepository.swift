//
//  RatingRepository.swift
//  MovieChill
//
//  Created by Danis Preldzic on 27. 6. 2024..
//

import Foundation


struct RatingRepository {
    
   private var networkService = NetworkService()
    
    func addRating<T: Decodable>(for id: String, value: Double, isTV: Bool = false, type: T.Type) async throws -> ResponseModel {
        
        var url: String = ApiPaths().getValue(api: .rating, concatValue: isTV ? "tv" : "movie", concatValue2: id)
        
        let json: [String: Any] = ["value": value]
        let postData = try JSONSerialization.data(withJSONObject: json)
        
        do {
            let data = try await networkService.postData(for: url, as: ResponseModel.self, postData: postData, headers: ApiHeaders().getValue(type: .app_json))
            return data
        } catch  {
            throw error
        }
    }

    let queryItemsCredits: [URLQueryItem] = [
      URLQueryItem(name: "language", value: "en-US"),
    ]
    
}
