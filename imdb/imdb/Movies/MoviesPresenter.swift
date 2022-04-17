//
//  MoviesPresenter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol MoviesPresentationLogic {
  func presentSomething(response: Movies.Movie.Response)
}

class MoviesPresenter: MoviesPresentationLogic {
  weak var viewController: MoviesDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Movies.Movie.Response) {
    let viewModel = Movies.Movie.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
