//
//  MoviesDetailInteractor.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol MoviesDetailBusinessLogic {
    func fetchMovieDetail(request: MoviesDetail.Detail.Request)
}

protocol MoviesDetailDataStore {
    var selectedMovieId: Int? { get set }
}

class MoviesDetailInteractor: MoviesDetailBusinessLogic, MoviesDetailDataStore {

    var selectedMovieId: Int?
    var presenter: MoviesDetailPresentationLogic?
    var worker: FetchingMovieDetailUsecase
    
    init(worker:FetchingMovieDetailUsecase) {
        self.worker = worker
    }
    
    // MARK: Do something
    
    func fetchMovieDetail(request: MoviesDetail.Detail.Request) {
        worker.fetchMovieDetail(request: request, completion: { result in
            switch result {
                case .success(let response):
                    self.presenter?.presentMovieResponse(response: response)
                case .failure(let error):
                    dump(error)
            }
        })
        
    }
}
