//
//  ViewController.swift
//  MovieListApp
//
//  Created by Anika Setia on 05/08/22.
//

import UIKit

class ViewController: UIViewController, MovieDataManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        cell.textLabel!.text = movies[indexPath.row].title
                return cell
    }
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var movieListCell: UITableViewCell!
    
    var movies:[MovieListModel] = []
    
    var movieManager: MovieDataManager = MovieDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchField.delegate = self
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        
        searchField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        movieManager.delegate = self
//        print(a.fetchMovieList(searchTerm: "sha", page: 1))
//        print(a.performDetailApiRequest(titleId: "tt14713814"))
    }
    
    func didGetMovieDetail(_ movieDataManager: MovieDataManager, movieDetail: MovieListModel) {
        print("movie detail received")
        print(movieDetail)
    }
    
    
    func didFailWithError(error: Error) {
        print("API call failed \(error)")
    }
    
    func didGetMovieListData(_ movieDataManager: MovieDataManager, movies: [MovieListModel]) {
        print("movies received")
        print(movies)
        self.movies = movies
        
        
        DispatchQueue.main.async {
            print(movies)
            self.movieListTableView.reloadData()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print(textField.text!)
        if(textField.text!.count >= 3){
            print(movieManager.fetchMovieList(searchTerm: textField.text!, page: 1))
            
        }
    }


}

