//
//  MoviesViewController.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol DisplayIndicatorLogic: AnyObject {
    func displayIndicator()
}

protocol MoviesDisplayLogic: AnyObject {
    func displayError(with message:String)
    func displayMovies(viewModel: Movies.Movie.ViewModel)
}

class MoviesViewController: UIViewController, MoviesDisplayLogic,DisplayIndicatorLogic {
    
    // MARK: IBOutlet
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = Movies.Movie.ViewModel()
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
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover"
        hideIndicator()
        registerCell()
        fetchMovies(page: 1)
    }
    
    // MARK: FetchingMovies
    
    func fetchMovies(page:Int) {
        let request = Movies.Movie.Request(page: page)
        interactor?.fetchMovies(request: request)
    }
    
    // MARK: - Presenter
    func displayMovies(viewModel: Movies.Movie.ViewModel) {
        self.viewModel  = viewModel
        moviesTableView.reloadData()
        hideIndicator()
    }
    
    func displayError(with message:String) {
        moviesTableView.reloadData()
        hideIndicator()
        showAlert(message: message, title: "Something went wrong")
    }
    
    func displayIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "MovieTableViewCell", bundle: .main)
        moviesTableView.register(cell, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
    }
}


extension MoviesViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movies[indexPath.row]
        interactor?.selectMovieObject(movieId: movie.movieId)
        router?.routeToDetail()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MoviesViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.shouldLoadMore && indexPath.row == viewModel.movies.count - 1 {
            fetchMovies(page: viewModel.nextPage)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as! MovieTableViewCell
        cell.setupCell(withModel: viewModel.movies[indexPath.row])
        return cell
    }
}
