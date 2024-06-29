//
//  CreditsRepository.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation
import SwiftUI
import Combine

struct CreditsRepository {
    
   private var networkService = NetworkService()
    
    
    func getCredits<T: Decodable>(for id: String, isTV: Bool = false, type: T.Type) async throws -> CreditsModel {
        
        var url: String = ApiPaths().getValue(api: isTV ? .tvCredits : .movieCredits, concatValue: id)
        
        do {
            let data = try await networkService.fetchData(from: url,
                                                          as: CreditsModel.self,
                                                          queryItems: queryItemsCredits,
                                                          headers: ApiHeaders().getValue(type: .json_token))
            return data
        } catch  {
            throw error
        }
    }
    
    let queryItemsCredits: [URLQueryItem] = [
      URLQueryItem(name: "language", value: "en-US"),
    ]
    
}
