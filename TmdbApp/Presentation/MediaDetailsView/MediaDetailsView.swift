//
//  MediaDetailsView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 14/6/23.
//

import SwiftUI
import Kingfisher

struct MediaDetailsView: View {
    
    @StateObject var mediaDetailsViewModel: MediaDetailsViewModel
    var baseUrlImage: String = "https://image.tmdb.org/t/p/w500"
    
    init(id: Int, type: Results){
        let viewModel = MediaDetailsViewModel(id: id, type: type)
        _mediaDetailsViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if let details = mediaDetailsViewModel.mediaDetails?.details {
            GeometryReader { proxi in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: -15) {
                        backDrop(name: details.backdrop ?? "", width: proxi.size.width)
                        
                        Group {
                            poster(details: details)
                            
                            tagline(details: details)
                            
                            overview(details: details)
                        }
                        .padding()
                        
                        posterRow(result: details.credits?.castResults ?? [], title: "Top Bill Cast", endpoint: "/\(mediaDetailsViewModel.type)/\(details.id)/credits", row: .cast)
                        
                        trailerRow(videos: details.videos.results)
                        
                        seasonRow(details: details, width: proxi.size.width)
                        
                        posterRow(result: details.recommendations?.result ?? [], title: "Recommendations", endpoint: "/\(mediaDetailsViewModel.type)/\(details.id)/credits", row: .cast)
                        
                        posterRow(result: details.similar?.result ?? [], title: "Similar", endpoint: "/\(mediaDetailsViewModel.type)/\(details.id)/credits", row: .cast)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        } else {
            ProgressView()
        }
    }
}

extension MediaDetailsView {
    @ViewBuilder
    func backDrop(name: String, width: CGFloat) -> some View {
        Image(url: baseUrlImage + name, width: width, height: 250, radius: 0)
    }
    
    @ViewBuilder
    func posterRow(result: [Result], title: String, endpoint: String, row: RowType) -> some View {
        if (!result.isEmpty) {
            ImageCardRow(title: title, imageCards: result, endPoint: endpoint, params: [:])
                .padding(.top)
        }
    }
    
    @ViewBuilder
    func poster(details: DetailsWrapper) -> some View {
        HStack {
            Image(url: baseUrlImage + (details.poster ?? ""), width: 120, height: 190)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(details.title)
                    .bold()
                    .font(.title)
                
                Text(StringHelper().convertDateString(details.date) ?? "Unknown release date")
                    .bold()
                
                Text(details.status ?? "")
                    .fontWeight(.light)
                
                Spacer()
            }
        }
        .padding(.top)
    }
    
    @ViewBuilder
    func tagline(details: DetailsWrapper) -> some View {
        if (details.tagline != "") {
            Text(details.tagline)
                .italic()
                .fontWeight(.light)
        }
    }
    
    @ViewBuilder
    func overview(details: DetailsWrapper) -> some View {
        Text("Overview")
            .bold()
            .font(.title2)
        
        Text(details.overview)
    }
    
    @ViewBuilder
    func trailerRow(videos: [VideosResult]) -> some View {
        if (!videos.isEmpty) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Trailers")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .padding(.bottom, 5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(videos.prefix(5), id: \.id) { video in
                            if let key = video.key {
                                WebView(url: "https://www.youtube.com/embed/\(key)")
                                    .frame(width: 320, height: 200)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .padding(.top)
            .padding(.vertical)
        }
    }
    
    @ViewBuilder
    func seasonRow(details: DetailsWrapper, width: CGFloat) -> some View {
        if let seasons = details.seasons, seasons.count > 0 {
            VStack(alignment: .leading, spacing: 5) {
                Text("Seasons")
                    .bold()
                    .font(.title2)
                    .padding(.leading)
                    .padding(.bottom, 5)
                
                Image(url: baseUrlImage + (seasons.last?.posterPath ?? ""), width: width, height: 240)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(seasons.prefix(seasons.count - 1).reversed(), id: \.id) { season in
                            Image(url: baseUrlImage + (season.posterPath ?? ""), width: 300, height: 190)
                        }
                        
                        ForEach(seasons.prefix(seasons.count - 1).reversed(), id: \.id) { season in
                            seasonCard(season: season, width: 300, height: 190)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .padding(.top)
        }
    }
    
    func seasonCard(season: Season, width: CGFloat, height: CGFloat) -> some View {
        VStack {
            KFImage(URL(string: baseUrlImage + (season.posterPath ?? "")))
                .placeholder() {
                    SwiftUI.Image("placeholder-backdrop")
                        .resizable()
                        .scaledToFill()
                }
                .cacheOriginalImage()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 2)
        }
    }
    
    @ViewBuilder
    func navigationBody() -> some View {
        SwiftUI.Image(systemName: "chevron.right")
            .foregroundColor(.blue)
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(id: 15, type: .movie)
    }
}
