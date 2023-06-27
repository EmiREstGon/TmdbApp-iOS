//
//  CastDetailsView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 21/6/23.
//

import SwiftUI
import Kingfisher

struct PersonDetailsView: View {
    
    @StateObject var personDetailsViewModel: PersonDetailsViewModel
    @State var isBiographyExpanded: Bool = false
    @State var isModalPresented: Bool = false
    @State var url: String? = nil
    
    let baseUrlImage = "https://image.tmdb.org/t/p/w500"

    init(id: Int){
        let viewModel = PersonDetailsViewModel(id: id)
        _personDetailsViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if let details = personDetailsViewModel.castDetails {
                GeometryReader { proxi in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: -15) {
                            avatar(details: details, width: proxi.size.width)
                            
                            titleAndSubtitle(details: details)
                            
                            Group {
                                VStack(alignment: .leading, spacing: .zero) {
                                    age(details: details)
                                    born(details: details)
                                }
                                
                                biography(details: details)
                            }
                            
                            ImageRow(image: details.images?.profiles ?? [], width: proxi.size.width, isModalPresented: $isModalPresented, url: $url)
                            
                            posterRow(result: details.combinedCredits?.cast ?? [], title: "Movies and TVs", endpoint: "/person/\(details.id ?? 0)/combined_credits", row: .cast)
                        }
                    }
                }
                .onChange(of: url, perform: { _ in
                    isModalPresented = true
                })
            } else {
                ProgressView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension PersonDetailsView {
    @ViewBuilder
    func avatar(details: PersonDetails, width: CGFloat) -> some View {
        VStack {
            Image(url: baseUrlImage + (details.profilePath ?? ""), width: width, height: 150, radius: 0)
                .padding(.horizontal, 5)
                .blur(radius: 10)
                .clipped()

            Image(url: baseUrlImage + (details.profilePath ?? ""), width: 160, height: 180)
                .offset(y: -100)
                .padding(.bottom, -80)
        }
    }
    
    func titleAndSubtitle(details: PersonDetails) -> some View {
        VStack {
            title(details: details)
                    
            subTitle(details: details)
        }
    }

    @ViewBuilder
    func title(details: PersonDetails) -> some View {
        HStack {
            Spacer()
            
            Text(details.name ?? "")
                .bold()
                .font(.title)
            
            Spacer()
        }
        .padding(.top)
    }

    @ViewBuilder
    func subTitle(details: PersonDetails) -> some View {
        HStack {
            Spacer()
            
            Text(details.knownForDepartment ?? "")
                .bold()
                .font(.title3)
            
            Spacer()
        }
        .padding(.bottom)
    }

    @ViewBuilder
    func age(details: PersonDetails) -> some View {
        let isBirthdayNil: Bool = details.birthday == nil || details.birthday == ""
        let birthday: Int? = Int(StringHelper().extractYearFromString(details.birthday ?? "") ?? "")
        let currentYear: Int = Calendar.current.component(.year, from: Date())
        let deathday: Int? = details.deathday?.description != nil ? Int(StringHelper().extractYearFromString(details.deathday ?? "") ?? "") : currentYear
        let birthdayText: String = (StringHelper().convertDateString(details.birthday ?? "") ?? "")
        let deathdayText: String = details.deathday?.description != nil ? (StringHelper().convertDateString(details.deathday ?? "") ?? "") : "now"
        let age: Int = (deathday ?? 0) - (birthday ?? 0)
        let ageText = "\(age) years old (\(birthdayText) - \(deathdayText))"
        
        VStack(alignment: .leading, spacing: 5) {
            Text(isBirthdayNil ? "Unknown birthday" : ageText)
                .font(.title3)
        }
        .padding(.top)
        .padding(.horizontal)
    }

    @ViewBuilder
    func born(details: PersonDetails) -> some View {
        let isplaceOfBirthNil: Bool = details.placeOfBirth == nil || details.placeOfBirth == ""
        let bornText = "Born in \(details.placeOfBirth ?? "")"
        
        VStack(alignment: .leading, spacing: 5) {
            Text(isplaceOfBirthNil ? "Unknown place of birth" : bornText)
                .font(.title3)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func biography(details: PersonDetails) -> some View {
        let isBiographyNil: Bool = details.biography == nil || details.biography == ""
        let biographyText = "\(details.biography ?? "")"
        
        VStack(alignment: .leading, spacing: 5) {
            Text("Biography")
                .bold()
                .font(.title2)
                .padding(.top)
            
            Text(isBiographyNil ? "No information available" : biographyText)
                .font(.title3)
                .lineLimit(isBiographyExpanded ? .max : 10)
                .onTapGesture {
                    isBiographyExpanded.toggle()
                }
        }
        .padding(.vertical)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func imagesRow(images: PersonImages?) -> some View {
        if let images = images, !(images.profiles?.isEmpty ?? false) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Images")
                    .bold()
                    .font(.title2)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(images.profiles ?? [], id: \.filePath) { profile in
                            if let filePath = profile.filePath,
                               let url = URL(string: "\(baseUrlImage)\(filePath)") {
                                KFImage(url)
                                    .frame(width: 90, height: 160)
                                    .scaledToFit()
                            }
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
    func posterRow(result: [Result], title: String, endpoint: String, row: RowType) -> some View {
        if (!result.isEmpty) {
            ImageCardRow(title: title, imageCards: result, endPoint: endpoint, params: [:])
                .padding(.top)
        }
    }
}

struct ImageRow: View {
    let image: [Profile]
    let width: CGFloat
    @Binding var isModalPresented: Bool
    @Binding var url: String?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(image, id: \.filePath) { image in
                        let url = "https://image.tmdb.org/t/p/w500" + (image.filePath ?? "")
                        
                        KFImage(URL(string: url))
                            .cacheOriginalImage()
                            .resizable()
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 220)
                            .onTapGesture {
                                self.url = url
                            }
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $isModalPresented) {
            if let url = url {
                KFImage(URL(string: url))
                    .cacheOriginalImage()
                    .resizable()
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 2)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width)
            }
        }
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(id: 10)
    }
}
