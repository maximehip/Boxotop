//
//  ContentView.swift
//  Boxotop
//
//  Created by Maxime on 19/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FilmViewModel()
    @State private var searchQuery: String = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if let films = viewModel.datas {
                        ForEach(films.Search, id: \.id) { film in
                            NavigationLink(destination: FilmDetailsView(id: film.id)) {
                                FilmRowView(film: film)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .searchable(text: $searchQuery)
                .onSubmit(of: .search, runSearch)
            }

            .navigationBarTitle("Boxotop")
        }
    }
    
    func runSearch() {
        viewModel.searchDatas(title: searchQuery)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FilmRowView: View {
    let film: FilmResult
    
    var body: some View {
        HStack(spacing: 16) {
            FilmImageView(imageURL: film.poster)
                .frame(width: 60, height: 90)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(film.title)
                    .font(.headline)
                Text(film.year)
                    .font(.subheadline)
            }
        }
    }
}

struct FilmImageView: View {
    let imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                Image(systemName: "photo")
                    .resizable()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.red)
            @unknown default:
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.gray)
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}
