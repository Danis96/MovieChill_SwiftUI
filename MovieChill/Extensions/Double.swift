//
//  Double.swift
//  MovieChill
//
//  Created by Danis Preldzic on 24. 6. 2024..
//

import Foundation


extension Double {
    
    // Converts a double into string representation
    /// ```
    /// Converts 1234.56 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.1f", self)
    }
    
    
}
