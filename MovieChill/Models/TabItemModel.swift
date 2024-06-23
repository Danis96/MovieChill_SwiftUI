//
//  TabItemModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation


struct TabItemModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let imageName: String
    
    static func == (lhs: TabItemModel, rhs: TabItemModel) -> Bool {
        lhs.id == rhs.id
    }
}
