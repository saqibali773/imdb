//
//  MoviesPresenter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol LoadingPresenterLogic {
    func presentLoader()
}

protocol MoviesPresentationLogic {
    func presentMovies(response: Movies.Movie.Response?)
    func presentError(with error:Error)
}

class MoviesPresenter: MoviesPresentationLogic,LoadingPresenterLogic {
    
    weak var viewController: (MoviesDisplayLogic & DisplayIndicatorLogic)?
    
    // MARK: Do something
    
    func presentSomething(response: Movies.Movie.Response) {
        let viewModel = Movies.Movie.ViewModel()
        viewController?.displayMovies(viewModel: viewModel)
    }
    
    // MARK: Do something
    func presentMovies(response: Movies.Movie.Response?) {
        
        if let response = response {
            var viewModel   = Movies.Movie.ViewModel()
            var movies = [Movies.Movie.ViewModel.MovieViewModel]()
            for moive in response.results {
                let moviesViewModel = Movies.Movie.ViewModel.MovieViewModel(title: moive.originalTitle,
                                                                            rating: "Rating: \(moive.voteAverage)",
                                                                            releaseYear: "Year: \(moive.releaseDate)",
                                                                            description: moive.overview,
                                                                            posterPath: moive.backdropPath!)
                
                movies.append(moviesViewModel)
            }
            viewModel.page = response.page
            viewModel.movies = movies
            viewController?.displayMovies(viewModel: viewModel)
        }
    }
    
    func presentError(with error:Error) {
        if let error = error as? APIError,
           let message = error.errorDescription {
            viewController?.displayError(with: message)
        } else{
            if let error = error as? Network.APIError {
                let message = error.localizedDescription
                viewController?.displayError(with: message)
            }
        }
    }
    
    func presentLoader() {
        viewController?.displayIndicator()
    }
}
