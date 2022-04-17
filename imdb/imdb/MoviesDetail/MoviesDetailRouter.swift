//
//  MoviesDetailRouter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

@objc protocol MoviesDetailRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MoviesDetailDataPassing {
    var dataStore: MoviesDetailDataStore? { get }
}

class MoviesDetailRouter: NSObject, MoviesDetailRoutingLogic, MoviesDetailDataPassing {
    weak var viewController: MoviesDetailViewController?
    var dataStore: MoviesDetailDataStore?
    
    
}
