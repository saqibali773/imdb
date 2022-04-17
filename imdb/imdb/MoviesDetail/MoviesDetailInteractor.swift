//
//  MoviesDetailInteractor.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol MoviesDetailBusinessLogic {
    func doSomething(request: MoviesDetail.Detail.Request)
}

protocol MoviesDetailDataStore {
    //var name: String { get set }
}

class MoviesDetailInteractor: MoviesDetailBusinessLogic, MoviesDetailDataStore {
    var presenter: MoviesDetailPresentationLogic?
    var worker: FetchingMovieDetailUsecase?
    
    // MARK: Do something
    
    func doSomething(request: MoviesDetail.Detail.Request) {
        worker?.fetchMovieDetail(request: request, completion: { result in
            switch result {
                case .success(let response):
                    self.presenter?.presentSomething(response: response)
                case .failure(let error):
                    dump(error)
            }
        })
        
    }
}
