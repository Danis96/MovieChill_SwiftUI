//
//  TVRepository.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation
import SwiftUI
import Combine

class TVRepository {
    
    private var networkService = NetworkService()
    
    func getTVShows<T: Decodable>(urlString: String, type: T.Type, page: String = "1") async throws -> TVModelResults {
        
        print("url: \(urlString)")
        print("page: \(page)")
        
        do {
            let data  = try await networkService.fetchData(from: urlString, as: TVModelResults.self, queryItems: setQueryItems(page: page), headers: headers)
            return data
        } catch let error {
            throw error
        }
    }
    
    func getTVShowPoster(urlString: String) async throws -> UIImage {
        
        print("url: \(urlString)")
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL)}
        
        do {
            let (data, _)  =  try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch  {
            throw error
        }
    }
    
    private func setQueryItems(page: String = "1") -> [URLQueryItem] {
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "include_adult", value: "false"),
          URLQueryItem(name: "include_null_first_air_dates", value: "false"),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: page),
          URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        return queryItems
    }
    
    private var headers: [String: String] {
        return [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZmZjYjQ5MDczMDA3ZWNkZTZiMzRjOTEyNTAzOTU4NCIsIm5iZiI6MTcxOTE3MjIxMC45NDAxNDYsInN1YiI6IjYyMzI0MTRmODNlZTY3MDAxYjI0OTkwYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jmJETuMM7QTCcw5UdOyNf1U4RiLPq50p1ika2BVBD3c"
        ]
    }
}
