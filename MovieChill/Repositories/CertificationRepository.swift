//
//  CertificationRepository.swift
//  MovieChill
//
//  Created by Danis Preldzic on 29. 6. 2024..
//

import Foundation

struct CertificationRepository {
    
    
   private var networkService = NetworkService()
    
    func getCertificates<T: Decodable>(forTV isTV: Bool = false, type: T.Type) async throws -> CertificationsData {
        
        let url: String = ApiPaths().getValue(api: .certifications, concatValue: isTV ? "tv" : "movie")
        
        do {
            let data = try await networkService.fetchData(from: url, as: CertificationsData.self, queryItems: [],  headers: ApiHeaders().getValue(type: .app_json))
            return data
        } catch  {
            throw error
        }
    }
    

    
}
