//
//  ResponseModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 27. 6. 2024..
//

import Foundation


// MARK: - ResponseModel
struct ResponseModel: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
