//
//  MovieViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 24. 6. 2024..
//

import Foundation


class MovieViewModel: ObservableObject {
    
    
    private var constants = MovieChillConstants()
    
    
    func returnGenreName(genreID: Int) -> String {
        for genre in constants.genres {
            if(genreID == genre.id) {
                return "\(genre.name) /"
            }
        }
        
        return ""
    }
    
}
