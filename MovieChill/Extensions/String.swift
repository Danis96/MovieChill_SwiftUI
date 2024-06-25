//
//  String.swift
//  MovieChill
//
//  Created by Danis Preldzic on 25. 6. 2024..
//

import Foundation

extension String {
    
    func formatDateString() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else {
            return self // Return the original string if the format is incorrect
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        
        return outputFormatter.string(from: date)
    }
    
}
