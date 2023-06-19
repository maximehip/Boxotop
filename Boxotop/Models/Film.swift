//
//  Film.swift
//  Boxotop
//
//  Created by Maxime on 19/06/2023.
//

import Foundation


struct Film: Codable, Identifiable {
    var id: String
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let awards: String
    let poster: String
    let metascore: String
    let imdbRating: String
    let imdbVotes: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "imdbID", title = "Title", year = "Year", rated = "Rated", released = "Released", runtime = "Runtime", genre = "Genre", director = "Director", writer = "Writer", actors = "Actors", plot = "Plot", awards = "Awards", poster = "Poster", metascore = "Metascore", imdbRating, imdbVotes
    }
    
}
