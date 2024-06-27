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
    
    func getMovies<T: Decodable>(type: T.Type, page: String = "1") async throws -> MovieModel {
        
        do {
            let data = try await networkService.fetchData(from:ApiPaths().getValue(api: .movies),
                                                           as: MovieModel.self,
                                                           queryItems: setQueryItems(page: page),
                                                           headers: ApiHeaders().getValue(type: .json_token))
            return data
        } catch let error {
            throw error
        }
    }
    
    func getMoviePoster(urlString: String) async throws -> UIImage {
        
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
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        return queryItems
    }
    
}
