//
//  MoviesDetailPresenter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol MoviesDetailPresentationLogic {
    func presentSomething(response: MoviesDetail.Detail.Response)
}

class MoviesDetailPresenter: MoviesDetailPresentationLogic {
    weak var viewController: MoviesDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: MoviesDetail.Detail.Response) {
        let viewModel = MoviesDetail.Detail.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
