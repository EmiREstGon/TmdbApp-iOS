//
//  Image.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 5/6/23.
//

import SwiftUI
import Kingfisher

Image: View {
    var url: String
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var shadow: CGFloat
    var radius: CGFloat
    var mode: SwiftUI.ContentMode
    
    init(url: String, placeholder: String = "placeholder-poster", width: CGFloat = 90, height: CGFloat = 160, shadow: CGFloat = 2, radius: CGFloat = 10, mode: SwiftUI.ContentMode = .fill) {
        self.url = url
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.shadow = shadow
        self.radius = radius
        self.mode = mode
    }
    
    var body: some View {
        VStack {
            KFImage(URL(string: url))
                .placeholder() {
                    SwiftUI.Image(placeholder)
                        .resizable()
                        .scaledToFill()
                }
                .cacheOriginalImage()
                .resizable()
                .aspectRatio(contentMode: mode)
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(radius)
                .shadow(radius: shadow)
        }
    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        Image(url: "https://image.tmdb.org/t/p/w500/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg")
    }
}
