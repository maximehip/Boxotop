//
//  SearchResult.swift
//  Boxotop
//
//  Created by Maxime on 19/06/2023.
//

import Foundation


struct SearchResult: Codable {
    let Search: [FilmResult]
    let totalResults: String
    let Response: String
}

struct FilmResult: Codable, Identifiable {
    let id: String
    let title: String
    let year: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}

