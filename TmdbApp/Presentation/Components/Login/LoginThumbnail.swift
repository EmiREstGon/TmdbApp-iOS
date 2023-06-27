//
//  LoginThumbnail.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 6/6/23.
//

import SwiftUI

struct LoginThumbnail: View {
    var body: some View {
        VStack {
            Text("🎬")
                .font(.system(size: 70))
            
            Text("Movies")
                .font(.system(size: 50))
                .bold()
        }
    }
}

struct LoginThumbnail_Preview: PreviewProvider {
    static var previews: some View {
        LoginThumbnail()
    }
}
