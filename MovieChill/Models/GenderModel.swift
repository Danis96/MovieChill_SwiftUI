//
//  GenderModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import Foundation


struct GenderModel: Identifiable, Equatable {
    let id: Int
    let name: String
    
    static func == (lhs: GenderModel, rhs: GenderModel) -> Bool {
        lhs.id == rhs.id
    }
}
