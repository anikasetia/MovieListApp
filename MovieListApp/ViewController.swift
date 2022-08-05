//
//  ViewController.swift
//  MovieListApp
//
//  Created by Anika Setia on 05/08/22.
//

import UIKit

class ViewController: UIViewController, MovieDataManagerDelegate {
    
    func didFailWithError(error: Error) {
        print("API call failed \(error)")
    }
    
    func didGetMovieListData(_ movieDataManager: MovieDataManager, movies: [MovieListModel]) {
//        print("movies received")
//        DispatchQueue.main.async {
//            print(movies)
//        }
    }
    
//    func didGetMovieDetail(_ movieDataManager: MovieDataManager, movieDetail: MovieModel) {
//        print("movie detail received")
//        print(movieDetail)
//    }
    
    func didGetMovieDetail(_ movieDataManager: MovieDataManager, movieDetail: MovieListModel) {
        print("movie detail received")
        print(movieDetail)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var a = MovieDataManager()
        a.delegate = self
        print(a.fetchMovieList(searchTerm: "sha", page: 1))
        print(a.performDetailApiRequest(titleId: "tt14713814"))
    }


}

