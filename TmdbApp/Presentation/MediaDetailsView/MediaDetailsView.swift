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
                        
                        seasonRow(details: details)
                        
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
        Image(url: baseUrlImage + name, placeholder: "placeholder-backdrop", width: width, height: 250, shadow: 2.5, radius: 0)
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
    func seasonRow(details: DetailsWrapper) -> some View {
        if let seasons = details.seasons, seasons.count > 0 {
            VStack(alignment: .leading, spacing: 5) {
                Text("Seasons")
                    .bold()
                    .font(.title2)
                    .padding(.leading)
                    .padding(.bottom, 5)
                
                seasonCard(season: seasons.last ?? Season(airDate: "", episodeCount: 0, id: 0, name: "", overview: "", posterPath: "", seasonNumber: 0), width: .infinity, height: 240)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
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
    
    @ViewBuilder
    func seasonCard(season: Season, width: CGFloat, height: CGFloat) -> some View {
        let releaseYear = StringHelper().extractYearFromString(season.airDate ?? "")
        
        ZStack{
            Image(url: "https://image.tmdb.org/t/p/w500" + (season.posterPath ?? ""), width: width, height: height)
            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(season.name ?? "")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 28))
                
                Text("\(season.episodeCount ?? 0) Episodes | \(releaseYear ?? "")")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .foregroundColor(.white)
            .padding()
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
