//
//  UIApplication.swift
//  SWAPI
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

