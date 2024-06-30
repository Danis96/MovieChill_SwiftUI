//
//  CertificationModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 29. 6. 2024..
//

import Foundation


// MARK: - CertificationModel
struct CertificationGroup: Identifiable, Decodable {
    var certifications: [Certification]
    let country: String
    let id: String = UUID().uuidString
}

struct CertificationsData: Identifiable, Decodable {
    let certifications: [String: [Certification]]
    let id: String = UUID().uuidString
}

// MARK: - Certification
struct Certification: Identifiable, Decodable {
    let certification, meaning: String
    let order: Int
    let id: String = UUID().uuidString
}
