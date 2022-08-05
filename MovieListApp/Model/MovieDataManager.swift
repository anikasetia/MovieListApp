//
//  MovieDataManager.swift
//  MovieListApp
//
//  Created by Anika Setia on 05/08/22.
//

import Foundation

protocol MovieDataManagerDelegate{
    func didFailWithError(error: Error)
    func didGetMovieListData(_ movieDataManager: MovieDataManager, movies: [MovieListModel])
    func didGetMovieDetail(_ movieDataManager: MovieDataManager, movieDetail: MovieListModel)
}

struct MovieDataManager{
    let movieDomain = "https://www.omdbapi.com/"
    let apiKey = "4071f6e9"
    
    var delegate: MovieDataManagerDelegate?
    
    func constructMovieDetailUrl(titleId: String) -> String{
        return "\(movieDomain)?i=\(titleId)&apikey=\(apiKey)"
    }
    
    func constructMovieListUrl(searchTerm: String, page: Int) -> String{
        return "\(movieDomain)?apikey=\(apiKey)&s=\(searchTerm)&page=\(page)"
    }
    
    func fetchMovieList(searchTerm: String, page:Int){
        return performApiRequest(with: constructMovieListUrl(searchTerm: searchTerm, page: page))
    }
    
    func fetchMovieDetail(titleId: String){
        
    }
    
    
    func performApiRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movieData = self.parseListJSON(safeData) {
                        self.delegate?.didGetMovieListData(self, movies: movieData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func performDetailApiRequest(titleId: String){
        let urlString = constructMovieDetailUrl(titleId: titleId)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movieData = self.parseDetailJSON(safeData) {
                        self.delegate?.didGetMovieDetail(self, movieDetail: movieData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseListJSON(_ movieListResponse: Data) -> [MovieListModel]? {
        print("parse list called")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieListResponse.self, from: movieListResponse)
            let results = decodedData.Search
            var movieList: [MovieListModel] = []
            for i in 0..<results.count{
                let movie = MovieListModel(title: results[i].Title, poster: results[i].Poster, year: results[i].Year, imdbID: results[i].imdbID)
                movieList.append(movie)
            }
            return movieList
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseDetailJSON(_ movieDetailResponse: Data) -> MovieListModel? {
        print("parse detail called")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieListItem.self, from: movieDetailResponse)
            let results = decodedData
            let movie = MovieListModel(title: results.Title, poster: results.Poster, year: results.Year, imdbID: results.imdbID)
            return movie
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
