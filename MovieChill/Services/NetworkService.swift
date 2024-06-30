//
//  DownloadRepository.swift
//  SWAPI
//
//  Created by Danis Preldzic on 10. 6. 2024..
//

import Foundation
import Combine


enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
}

struct NetworkService {
    
    func fetchData<T: Decodable>(from urlString: String, as type: T.Type, queryItems: [URLQueryItem], headers: [String: String]) async throws -> T {
       
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if !queryItems.isEmpty {
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            /// When debug decoding
            if let string = String(data: data, encoding: .utf8) {
                print("Data string: \(string)")
            } else {
                print("Failed to parse data")
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } catch let error as DecodingError {
            print(error.localizedDescription)
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
    
    func postData<T: Decodable>(for urlString: String, as type: T.Type, postData: Data, headers: [String: String]) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = headers
        
        request.httpBody = postData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // When debug decoding
//            if let string = String(data: data, encoding: .utf8) {
//                print("Data string: \(string)")
//            } else {
//                print("Failed to parse data")
//            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch let error {
            throw NetworkError.requestFailed(error)
        }
    }
    
}
