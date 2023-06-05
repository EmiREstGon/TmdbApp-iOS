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

//                            if let seasons = details.seasson, seasons.count > 0 {
//                                seasonRow(seassons: seasons)
//                            }
                        }
                        .padding()

                        posterRow(result: details.credits?.castResults ?? [], title: "Top Bill Cast", endpoint: "/\(mediaDetailsViewModel.type)/\(details.id)/credits", row: .cast)
                        
                        trailerRow(videos: details.videos.results)

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
    func backDrop(name:String, width: CGFloat) -> some View {
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
                
                Text(StringHelper().convertDateString(details.date) ?? "")
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
        Text(details.tagline)
            .italic()
            .fontWeight(.light)
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
                    .padding(.horizontal)
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
    func seasonRow(seasons: Season) -> some View {
        Text("Seasons")
            .bold()
            .font(.title2)
    }
    
    @ViewBuilder
    func seasonCard(seasons: Season, width: CGFloat, height: CGFloat) -> some View {
        
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
