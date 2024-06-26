//
//  CreditsModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation
import SwiftUI

// MARK: - CreditsModel
struct CreditsModel: Identifiable, Codable {
    let id: String = UUID().uuidString
    let movieID: Int
    let cast, crew: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case cast, crew
        case movieID = "id"
    }
}

// MARK: - Cast
struct Cast: Identifiable, Codable, Equatable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department, job: String?
    var profileFullPath: String?
    var imageData: Image?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    func updateProfilePath(newPathProfile: String) -> Cast {
        Cast(adult: adult, gender: gender, id: id, knownForDepartment: knownForDepartment, name: name, originalName: originalName, popularity: popularity, profilePath: profilePath, castID: castID, character: character, creditID: creditID, order: order, department: department, job: job, profileFullPath: newPathProfile)
    }
    
    static func == (lhs: Cast, rhs: Cast) -> Bool {
        lhs.id == rhs.id
    }
}
