//
//  SearchBarComponent.swift
//  Crypto_SwiftUI
//
//  Created by Danis Preldzic on 13. 6. 2024..
//

import SwiftUI

struct SearchBarComponent: View {
    
    @Binding var textFieldText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.black)
            
            TextField("Search by name...", text: $textFieldText)
                .foregroundStyle(Color.gray)
                .overlay(alignment: .trailing, content: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.gray)
                        .autocorrectionDisabled(true)
                        .opacity(textFieldText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            textFieldText = ""
                        }
                })
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.gray.opacity(0.15))
                .shadow(
                    color: Color.gray.opacity(0.15),
                    radius: 10
                )
        )
        .padding()
    }
}

#Preview {
    SearchBarComponent(textFieldText: (.constant("")))
        .previewLayout(.sizeThatFits)
}

