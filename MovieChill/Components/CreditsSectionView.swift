//
//  CreditsSectionView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI

struct CreditsSectionView: View {
    
    @EnvironmentObject private var movieVM: MovieViewModel
    @EnvironmentObject private var tvShowVM: TVShowsViewModel
    let credits: [Cast]
    let isTV: Bool
    
    private let locale = LocaleStrings()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            VStack {
                VStack(alignment: .leading) {
                    navigationTitle
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(credits) { cast in
                            VStack {
                                imageSection(cast: cast)
                                if let character = cast.character {
                                    Text(character)
                                }
                                Divider()
                                Text(cast.name)
                                    .font(.headline)
                            }
                            .frame(height: 240)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .shadow(radius: 10)
                            )
                            .cornerRadius(8)
                        }
                    }.padding()
                }
                
                showMoreLessButton
                
                Divider()
                    .frame(height: 40)
        }
    }
}

extension CreditsSectionView {
    private func imageSection(cast: Cast) -> some View {
        return VStack {
            if let image = cast.imageData {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140)
                    .clipped()
            }
        }
    }
    
    private var showMoreLessButton: some View {
        Button(action: {
            withAnimation(.smooth) {
                if isTV {
                    tvShowVM.showMoreCast.toggle()
                } else {
                    movieVM.showMoreCast.toggle()
                }
            }
        }, label: {
            if isTV {
                Text(tvShowVM.showMoreCast ? locale.creditsShowLess : locale.creditsShowMore)
            } else {
                Text(movieVM.showMoreCast ? locale.creditsShowLess : locale.creditsShowMore)
            }
            
        }).buttonStyle(.bordered)
    }
    
    private var navigationTitle: some View {
        Text(locale.creditsNavigationTitle)
            .font(.headline)
            .padding()
    }
    
}

#Preview {
    CreditsSectionView(credits: DeveloperPreview.instance.castList, isTV: false)
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.tvShowViewModel)
}
