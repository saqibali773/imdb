//
//  MoviesRouter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.


import UIKit

@objc protocol MoviesRoutingLogic {
    func routeToDetail()
}

protocol MoviesDataPassing {
    var dataStore: MoviesDataStore? { get }
}

class MoviesRouter: NSObject, MoviesRoutingLogic, MoviesDataPassing {
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
    
    // MARK: Routing
    func routeToDetail() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        MovieDetailModuleConfigurator().configureModule(for: destinationVC)
    
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToSomewhere(source: MoviesViewController, destination: MoviesDetailViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToSomewhere(source: MoviesDataStore, destination: inout MoviesDetailDataStore) {
        destination.selectedMovieId = source.selectedMovieId
    }
    
    
}
