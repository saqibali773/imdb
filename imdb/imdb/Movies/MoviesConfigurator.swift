//
//  MoviesConigurator.swift
//  imdb
//
//  Created by Saqib Ali on 18/04/2022.
//

import Foundation
final class MoviesConfigurator: NSObject {
    
    func configureModule(for viewController: MoviesViewController) {
        configure(viewController: viewController)
    }
    
    private func configure(viewController: MoviesViewController) {
        let worker = MoviesWorker(service: Network())
        let interactor = MoviesInteractor(worker: worker)
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        viewController.pageNumber = 1
    }
}
