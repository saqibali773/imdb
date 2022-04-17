//
//  MoviesViewController.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func displaySomething(viewModel: Movies.Movie.ViewModel)
}

class MoviesViewController: UIViewController, MoviesDisplayLogic {
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?
    
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
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    
    func doSomething() {
        let request = Movies.Movie.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Movies.Movie.ViewModel) {
    }
}
