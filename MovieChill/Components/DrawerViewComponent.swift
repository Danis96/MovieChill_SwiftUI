//
//  SideMenuViewComponent.swift
//  MovieChill
//
//  Created by Danis Preldzic on 30. 6. 2024..
//

import SwiftUI

struct DrawerViewComponent: View {
    
    var headerView: (any View)?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                if let header = headerView {
                    AnyView(header)
                } else {
                    headerViewPlaceholder
                }
            
                VStack(alignment: .leading, spacing: 20) {
                    DrawerItemView(destination: Text("Danis"), title: "Home", icon: "house")
                    DrawerItemView(destination: Text("Danis"), title: "Certification", icon: "menucard")
                }
                .padding()
                    
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.backgroundBlue1)
            .foregroundStyle(.white)
            .edgesIgnoringSafeArea(.all)
        }
    
    }
}

extension DrawerViewComponent {

    
    private var headerViewPlaceholder: some View {
        HStack() {
            Text("Header placeholder")
            Spacer()
            Image(systemName: "greetingcard")
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
        .padding(.horizontal)
    }
}

#Preview {
    DrawerViewComponent(headerView: nil)
}
