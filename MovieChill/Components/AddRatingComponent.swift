//
//  AddRatingComponent.swift
//  MovieChill
//
//  Created by Danis Preldzic on 28. 6. 2024..
//

import SwiftUI

struct AddRatingComponent: View {
    
    @Binding var presentAlert: Bool
    @Binding var sliderValue: Double
    var onDonePressed: () async -> Void
    
    private let locale = LocaleStrings()
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                presentAlert.toggle()
            }
        } label: {
            HStack {
                Text(locale.ratingAddRating)
                Image(systemName: "plus.circle")
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(.backgroundBlue1)
        .sheet(isPresented: $presentAlert) {
            sliderSheetView
        }
    }
}

extension AddRatingComponent {
    
    private var backgroundView: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("BackgroundBlue1"),Color("BackgroundBlue2")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).ignoresSafeArea()
    }
    
    private var sliderSheetView: some View {
        ZStack {
            backgroundView
            VStack {
                
                infoText
                
                Slider(value: $sliderValue, in: 0.0...10.0, step: 0.5)
                    .tint(SliderHelpers().returnCorrectColorStatus(sliderValue: sliderValue))
                    .padding()
                
                HStack {
                    Text("\(locale.ratingCurrentR): \(sliderValue, specifier: "%.1f") / 10")
                    
                    Image(systemName: SliderHelpers().returnCorrectHandIcon(sliderValue: sliderValue))
                }
                
                Button(action: {
                    Task {
                        await onDonePressed()
                    }
                    presentAlert = false
                }) {
                    Text(locale.ratingDoneButton)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .foregroundStyle(Color("TextColor"))
            .padding()
        }
    }
    
    private var infoText: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(locale.ratingYourRate).font(.title2)
            
            Text(locale.ratingInfoText1)
                .font(.subheadline)
            
            Text(locale.ratingInfoText2)
                .font(.subheadline)
            
            Text(locale.ratingInfoText3)
                .font(.subheadline)
            
        }.padding()
    }
}

#Preview {
    AddRatingComponent(presentAlert: .constant(false), sliderValue: .constant(0.5)) {
        
    }
}
