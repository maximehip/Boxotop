//
//  Api.swift
//  Boxotop
//
//  Created by Maxime on 19/06/2023.
//

import Foundation
import Alamofire

class FilmService {
    private let baseURL = "http://www.omdbapi.com/"
    private let apiKey = "a3a6376a"
    
    func searchData(title: String, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        let parameters: Parameters = [
            "apikey": apiKey,
            "s": title,
            "type": "movie"
        ]
        
        AF.request(baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: SearchResult.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func searchFilm(id: String, completion: @escaping (Result<Film, Error>) -> Void) {
        let parameters: Parameters = [
            "apikey": apiKey,
            "i": id,
        ]
        
        AF.request(baseURL, parameters: parameters)
            .validate()
            .responseDecodable(of: Film.self) { response in
                switch response.result {
                case .success(let searchResponse):
                    completion(.success(searchResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

