//
//  MoviesInteractor.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.

//

import UIKit

protocol MoviesBusinessLogic {
    func selectMovieObject(movieId: Int)
    func fetchMovies(request: Movies.Movie.Request)
}

protocol MoviesDataStore {
    var selectedMovieId: Int? { get set }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    var selectedMovieId: Int?
    var movies: [Movies.Movie.MovieModel] = []
    var movieResponse: Movies.Movie.Response?
    
    var presenter: (MoviesPresentationLogic & LoadingPresenterLogic)?
    var worker: FetchMoviesUsecase?
    
    init(worker:FetchMoviesUsecase) {
        self.worker = worker
    }
    
    func selectMovieObject(movieId: Int) {
        selectedMovieId = movieId
    }
    
    // MARK: Do something
    
    func fetchMovies(request: Movies.Movie.Request) {
        
        if movieResponse == nil {
            presenter?.presentLoader()
        }
        
        worker?.fetchMoviesList(request: request, completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
                case.success(let response):
                    self.movieResponse = response
                    if response.page > 1  {
                        self.movies += response.results
                        self.movieResponse?.results = self.movies
                    } else {
                        self.movies = response.results
                    }
                    self.presenter?.presentMovies(response: self.movieResponse)
                case.failure(let error):
                    self.presenter?.presentError(with: error)
            }
        })
    }
}
