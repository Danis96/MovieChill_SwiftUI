//
//  MovieRepository.swift
//  MovieChill
//
//  Created by Danis Preldzic on 24. 6. 2024..
//

import Foundation
import SwiftUI
import Combine
class MovieRepository {
    
    
    private var networkService = NetworkService()
    
    func getMovies<T: Decodable>(urlString: String, type: T.Type) async throws -> MovieModel {
        
        print("url: \(urlString)")
        
        do {
            let data  = try await networkService.fetchData(from: urlString, as: MovieModel.self, queryItems: setQueryItems(), headers: headers)
            return data
        } catch let error {
            throw error
        }
    }
    
    func getMoviePoster(urlString: String) async throws -> UIImage {
        
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
    
    // MARK: I can refactor this and create selectable queries...
    // also call again when I came to last two or one movie [MAKE IT LIKE INFINITE SCROLLING]
    private func setQueryItems() -> [URLQueryItem] {
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "include_adult", value: "false"),
          URLQueryItem(name: "include_video", value: "false"),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
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
