//
//  DrawerItemView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 30. 6. 2024..
//

import SwiftUI

struct DrawerItemView: View {
    
    var destination: (any View)
    let title: String
    var foregroundColor: Color?
    var icon: String?
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: AnyView(destination)) {
                
                HStack {
                    Text(title)
                        .foregroundStyle(foregroundColor ?? .white)
                    Spacer()
                    if let ic = icon {
                        Image(systemName: ic)
                    }
                }
            }
            .frame(maxWidth: 125, maxHeight: 20)
        }

    }
}

#Preview {
    DrawerItemView(
      destination: Text("Test view"),
      title: "Home",
      foregroundColor: .black,
      icon: "arrow.down"
    )
}
