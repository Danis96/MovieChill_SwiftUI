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

class NetworkService {

    func fetchData<T: Decodable>(from urlString: String, as type: T.Type) async throws -> T {
        // Check if the URL string can be converted to a URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            // Fetch data from the URL
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the data into the specified type
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
    
    
    
    
    
}
