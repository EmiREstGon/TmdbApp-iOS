//
//  SearchView.swift
//  TmdbApp
//
//  Created by Emilio Rafael Estévez González on 29/6/23.
//

import SwiftUI

struct SearchView: View {
    @State var query: String = ""
    @State var selection: Int = 1
    
    struct Search: Identifiable {
        var id: Int
        var name: String
        var endpoint: String
        var type: RowType
    }
    
    private let searchs: [Search] = [.init(id: 1, name: "Movie", endpoint: "search/movie", type: .media), .init(id: 2, name: "TV", endpoint: "search/tv", type: .media)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            SearchBar(query: $query)
            
            if query.isEmpty {
                Text("Type something to explore...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack(alignment: .leading, spacing: .zero) {
                    Picker(selection: $selection, label: Text("")) {
                        ForEach(searchs) { search in
                            Text(search.name).tag(search.id)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    TabView(selection: $selection) {
                        ForEach(searchs) { search in
                            GridView(endpoint: search.endpoint, params: ["query" : query], type: search.type).tag(search.id)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.bottom)
                    .id(query)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Explore")
        .navigationBarHidden(false)
    }
}

struct SearchBar: View {
    @Binding var query: String
    @State var text: String = ""
    @State var isEditing: Bool = false
    @State private var showCancelButton: Bool = false

    
    var body: some View{
        HStack {
            HStack {
                SwiftUI.Image(systemName: "magnifyingglass")
                
                TextField("Search...", text: $text, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    self.query = text
                }).foregroundColor(.primary)
                
                Button(action: {
                    self.text = ""
                }) {
                    SwiftUI.Image(systemName: "xmark.circle.fill").opacity(text == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if showCancelButton {
                Button("Cancel") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.text = ""
                        self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
                .transition(.move(edge: .trailing))
                .animation(.default, value: showCancelButton)
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
