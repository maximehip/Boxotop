//
//  FilmViewModel.swift
//  Boxotop
//
//  Created by Maxime on 19/06/2023.
//

import Foundation

class FilmViewModel: ObservableObject {
    @Published var datas: SearchResult?
    @Published var film: Film?
    
    private let filmService: FilmService
    
    init(filmService: FilmService = FilmService()) {
        self.filmService = filmService
    }
    
    func searchDatas(title: String) {
        filmService.searchData(title: title) { result in
            switch result {
            case .success(let films):
                DispatchQueue.main.async {
                    self.datas = films
                    
                }
            case .failure(let error):
                print("Search error: \(error)")
            }
        }
    }
    
    func getFilm(id: String, completion: @escaping () -> Void) {
        filmService.searchFilm(id: id) { result in
            switch result {
            case .success(let films):
                DispatchQueue.main.async {
                    self.film = films
                    completion()
                }
            case .failure(let error):
                print("Search error: \(error)")
            }
        }
    }
}
