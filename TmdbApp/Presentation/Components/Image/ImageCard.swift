//
//  ImageCard.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 5/6/23.
//

import SwiftUI

struct ImageCard: View {
    
    let result: Result
    var width: CGFloat = 110
    var height: CGFloat = 160
    var alpha: CGFloat = 0.45
    var baseUrlImage: String = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(url: baseUrlImage + result.image, width: width, height: height)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(result.title)
                    .font(.headline)
                    .lineLimit(1)
                
                if let subtitle = result.subtitle {
                    Text(StringHelper().convertDateString(subtitle) ?? subtitle)
                        .lineLimit(1)
                }
                
                if let character = result.character {
                    if !character.isEmpty {
                        Text(character)
                            .lineLimit(1)
                    }
                }
            }
            .frame(minHeight: alpha * height, alignment: .top)
        }
        .frame(width: width)
    }
}

struct ImageCard_Previews: PreviewProvider {
    static var previews: some View {
        
        let result = Result(id: 1, title: "The Super Mario Bros Movie", subtitle: "Subtítulo", character: "Personaje", image: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", type: .movie)
        
        ImageCard(result: result)
    }
}
