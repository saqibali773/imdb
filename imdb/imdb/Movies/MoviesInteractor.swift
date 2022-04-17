//
//  MoviesInteractor.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.

//

import UIKit

protocol MoviesBusinessLogic {
  func doSomething(request: Movies.Movie.Request)
}

protocol MoviesDataStore {
  //var name: String { get set }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
  var presenter: MoviesPresentationLogic?
  var worker: MoviesWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Movies.Movie.Request) {
  
  }
}
