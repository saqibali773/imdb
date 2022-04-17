//
//  MoviesRouter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.


import UIKit

@objc protocol MoviesRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MoviesDataPassing {
  var dataStore: MoviesDataStore? { get }
}

class MoviesRouter: NSObject, MoviesRoutingLogic, MoviesDataPassing {
  weak var viewController: MoviesViewController?
  var dataStore: MoviesDataStore?
  
  // MARK: Routing
  

}
