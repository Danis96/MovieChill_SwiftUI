//
//  TVShowView.swift
//  MovieChill
//
//  Created by Danis Preldzic on 26. 6. 2024..
//

import SwiftUI


struct TVShowView: View {

    @EnvironmentObject var tvShowVM: TVShowsViewModel
    
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            tvShowScrollView
                .padding(.vertical, 40)
                .sheet(item: $tvShowVM.tvShowSheet) { tvShow in
                    TVShowDetailsView(tvShow: tvShow)
                        .environmentObject(tvShowVM)
                }
            
            HStack {
                if currentIndex != 0 {
                    previousButton()
                }
                Spacer()
                if currentIndex < tvShowVM.tvShowsList.count - 1 {
                    nextButton()
                }
            }.padding(.horizontal, 25)
             .foregroundStyle(Color("TextColor"))
            
        }.animation(.easeInOut(duration: 0.5), value: currentIndex)
    }
}


extension TVShowView {
    
    private var tvShowScrollView: some View {
        GeometryReader { geometry in
            if tvShowVM.isLoading {
                ProgressView()
                    .tint(Color("TextColor"))
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                HStack(spacing: 20) {
                    ForEach(Array(tvShowVM.tvShowsList.enumerated()), id: \.offset) { index, tvShow in
                        tvShowPosterView(tvShow: tvShow, index: index)
                            .frame(width: geometry.size.width)
                            .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                            .opacity(currentIndex == index ? 1.0 : 0.0)
                            .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            .onTapGesture {
                                withAnimation {
                                    currentIndex = index
                                    tvShowVM.tvShowSheet = tvShow
                                }
                    }
                }
            }
                .offset(x: CGFloat(currentIndex) * -(geometry.size.width + 20))
        }
    }
}

private func tvShowPosterView(tvShow: TVModel, index: Int) -> some View {
    VStack(spacing: 40) {
        if let posterImage = tvShow.imageData {
            posterImage
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 200, height: 300)
                .cornerRadius(10)
                .shadow(radius: 15)
        }
        
        tvShowTextPoster(tvShow: tvShow, index: index)
    }
}

private func tvShowTextPoster(tvShow: TVModel, index: Int) -> some View {
    VStack(alignment: .center, spacing: 10) {
        if currentIndex == index {
            Text(tvShow.name)
                .frame(maxWidth: UIScreen.main.bounds.width / 1.2)
                .font(.title)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            
            HStack {
                ForEach(tvShow.genreIDS.prefix(3), id: \.self) { genreID in
                    Text("\(tvShowVM.returnGenreName(genreID: genreID))")
                        .font(.caption)
                }
            }
            
            HStack(alignment: .center) {
                Text(tvShow.voteAverage.asNumberString())
                    .font(.title)
                
                Image(systemName: "hands.clap.fill")
            }
        }
    }.foregroundStyle(Color("TextColor"))
}

private func calculateOffset(cardWidth: CGFloat, spacing: CGFloat, geometry: GeometryProxy) -> CGFloat {
    let centeredOffset = (geometry.size.width - cardWidth) / 2
    let indexOffset = CGFloat(currentIndex) * -(cardWidth + spacing)
    
    return indexOffset + centeredOffset
}
    


private func nextButton() -> some View {
    Button(action: {
        withAnimation(.spring) {
            currentIndex = min(currentIndex + 1, tvShowVM.tvShowsList.count - 1)
            if currentIndex == tvShowVM.tvShowsList.count - 2 {
                tvShowVM.setPageNumber(value: tvShowVM.pageNumber + 1)
                Task {
                    await tvShowVM.fetchTVShows(shouldSetLoader: false)
                    await tvShowVM.fetchBackdropPosters()
                }
            }
        }
    }, label: {
        Text("Next")
            .font(.headline)
            .frame(width: 100)
    }).buttonStyle(.bordered)
}

private func previousButton() -> some View {
    Button(action: {
        withAnimation(.spring) {
            currentIndex = max(currentIndex - 1, 0)
        }
    }, label: {
        Text("Previous")
            .font(.headline)
            .frame(width: 100)
    }).buttonStyle(.bordered)

}

}

#Preview {
    TopTabsView()
        .environmentObject(DeveloperPreview.instance.movieViewModel)
        .environmentObject(DeveloperPreview.instance.tabsViewModel)
        .environmentObject(DeveloperPreview.instance.tvShowViewModel)
}
