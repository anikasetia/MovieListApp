//
//  MovieData.swift
//  MovieListApp
//
//  Created by Anika Setia on 05/08/22.
//

import Foundation

struct MovieListItem: Codable{
    let Title:String
    let Poster: String
    let Year: String
    let imdbID: String
}

struct MovieListResponse: Codable{
    let Response: String
    let Search: [MovieListItem]
}

struct MovieDetail: Codable{
    let Actor: String
    let Title: String
}
