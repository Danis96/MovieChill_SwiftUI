//
//  ReviewInfoComponent.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI

struct ReviewInfoComponent: View {
    
    let count: Int
    var onTapPressed: () async -> Void
    
    var body: some View {
        Button(action: {
            Task {
                await onTapPressed()
            }
        }, label: {
            HStack(alignment: .center) {
                Text(LocaleStrings().reviewsButtonTitle)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(count == 0 ? .red : .green)
                    .overlay {
                        if count != 0 {
                            Text(String(count))
                                .font(count < 10 ? .caption : .system(size: 10))
                                .fontWeight(.bold)
                                .foregroundStyle(.text)
                        }
                    }
            }
        }).buttonStyle(.bordered)
    }
}

#Preview {
    ReviewInfoComponent(count: 13) {
        
    }
}
