//
//  MovieModel.swift
//  MovieListApp
//
//  Created by Anika Setia on 05/08/22.
//

import Foundation

struct MovieModel{
    let actors: String
    let awards: String
    let title: String
    let plot: String
    let poster: String
}

struct Rating{
    let source: String
    let valeu: String
}

struct MovieListModel{
    let title:String
    let poster: String
    let year: String
    let imdbID: String
}

struct MovieListResponseModel{
    let response: String
    let search: [MovieListModel]
    let totalResults: String
}
