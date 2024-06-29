//
//  SliderHelpers.swift
//  MovieChill
//
//  Created by Danis Preldzic on 28. 6. 2024..
//

import Foundation
import SwiftUI

struct SliderHelpers {
    
    func returnCorrectHandIcon(sliderValue: Double) -> String {
        return sliderValue < 10 ? "hands.clap" : "hands.clap.fill"
    }
    
    func returnCorrectColorStatus(sliderValue: Double) -> LinearGradient {
        if sliderValue < 4 {
            return returnGradient(col: .red)
        } else if sliderValue >= 4 && sliderValue < 8 {
            return  returnGradient(col: .yellow)
        } else {
            return  returnGradient(col: .green)
        }
    }
    
   private func returnGradient(col: Color) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [col.opacity(0.8), col]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
}
