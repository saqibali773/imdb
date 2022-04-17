//
//  MovieDetailConfigurator.swift
//  imdb
//
//  Created by Saqib Ali on 18/04/2022.
//

import Foundation

final class MovieDetailModuleConfigurator: NSObject {
    
    func configureModule(for viewController: MoviesDetailViewController) {
        configure(viewController: viewController)
    }
    
    private func configure(viewController: MoviesDetailViewController) {
        
        let worker = MovieDetailWorker(service: Network())
        let interactor = MoviesDetailInteractor(worker: worker)
        let presenter = MoviesDetailPresenter()
        let router = MoviesDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
