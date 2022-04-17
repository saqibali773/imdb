//
//  MoviesDetailViewController.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.

import UIKit

protocol MoviesDetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: MoviesDetail.Detail.ViewModel)
}

class MoviesDetailViewController: UIViewController, MoviesDetailDisplayLogic {
    var interactor: MoviesDetailBusinessLogic?
    var router: (NSObjectProtocol & MoviesDetailRoutingLogic & MoviesDetailDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MoviesDetailInteractor()
        let presenter = MoviesDetailPresenter()
        let router = MoviesDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
        
    func doSomething() {
        let request = MoviesDetail.Detail.Request(movieId: 1)
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: MoviesDetail.Detail.ViewModel) {
    }
}
