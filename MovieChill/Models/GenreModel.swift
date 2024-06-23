//
//  GenreModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 24. 6. 2024..
//

import Foundation

struct GenreModel: Identifiable, Equatable {
    let id: Int
    let name: String
    
    static func == (lhs: GenreModel, rhs: GenreModel) -> Bool {
        lhs.id == rhs.id
    }
}
