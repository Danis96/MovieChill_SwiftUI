//
//  TabViewModel.swift
//  MovieChill
//
//  Created by Danis Preldzic on 23. 6. 2024..
//

import Foundation
import SwiftUI

@MainActor
class TabViewModel: ObservableObject {
    @Published var selectedTab: TabItemModel
    @Published var navigateToCertifications: Bool = false
    
    let tabs: [TabItemModel] = [
        TabItemModel(title: LocaleStrings().ttvDiscoverMovies, imageName: "house"),
        TabItemModel(title: LocaleStrings().ttvDiscoverTV, imageName: "magnifyingglass"),
    ]
    
    init() {
        self.selectedTab = tabs.first! // will always have
    }
}
