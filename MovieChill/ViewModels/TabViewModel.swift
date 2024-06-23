//
//  TabViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation
import SwiftUI

class TabViewModel: ObservableObject {
    @Published var selectedTab: TabItemModel
    
    let tabs: [TabItemModel] = [
        TabItemModel(title: "Discover Movies", imageName: "house"),
        TabItemModel(title: "TV", imageName: "magnifyingglass"),
    ]
    
    init() {
        self.selectedTab = tabs.first! // will always have
    }
}
