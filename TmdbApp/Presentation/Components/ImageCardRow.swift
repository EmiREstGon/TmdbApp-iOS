//
//  ImageCardRow.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 5/6/23.
//

import SwiftUI

struct ImageCardRow: View {
    
    var title: String = "Title"
    var imageCards: [Result] = []
    var endPoint: String
    var params: [String: Any] = [:]
    var type: RowType = .media
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                NavigationLink(destination: Text("Redirection")) {
                    navigationBody()
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(imageCards, id: \.uuid) { card in
                        cards(result: card)
                            .toDetailsView(result: card)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    func navigationBody() -> some View {
        SwiftUI.Image(systemName: "chevron.right")
            .foregroundColor(.blue)
    }
    
    @ViewBuilder
    func cards(result: Result) -> some View {
        if (result.type == .person) {
            ImageCard(result: result, height: 110, alpha: 0.65)
        } else {
            ImageCard(result: result)
        }
    }
}

//struct ImageCardRow_Preview: PreviewProvider {
//    static var previews: some View {
//        
//        let imageCards: [Result] = [
//            Result(id: 1, title: "The Super Mario Bros Movie", subtitle: "Subtítulo", image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", type: .movie),
//            Result(id: 2, title: "The Super Mario Bros Movie", subtitle: "Subtítulo", image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", type: .movie),
//            Result(id: 3, title: "The Super Mario Bros Movie", subtitle: "Subtítulo", image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", type: .movie),
//            Result(id: 4, title: "The Super Mario Bros Movie", subtitle: "Subtítulo", image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", type: .movie),
//            Result(id: 5, title: "The Super Mario Bros Movie", subtitle: "Subtítulo", image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", type: .movie)
//        ]
//        
//        ImageCardRow(imageCards: imageCards)
//    }
//}
