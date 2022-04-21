//
//  MovieListMockViewController.swift
//  imdbTests
//
//  Created by Saqib Ali on 22/04/2022.
//

import XCTest
@testable import imdb

class MovieListMockViewController:MoviesDisplayLogic,DisplayIndicatorLogic {
   
    var errorMessage:String?
    var viewModel = Movies.Movie.ViewModel()
 
    func displayError(with message: String) {
        self.errorMessage = message
    }
    
    func displayMovies(viewModel: Movies.Movie.ViewModel) {
        self.viewModel = viewModel
    }
    
    func displayIndicator() {
        
    }
}
