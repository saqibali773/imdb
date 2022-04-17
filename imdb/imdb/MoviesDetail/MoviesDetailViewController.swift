//
//  MoviesDetailViewController.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.

import UIKit
import ParallaxHeader
import AlamofireImage

protocol MoviesDetailDisplayLogic: AnyObject {
    func setupMovieDetails(_ viewModel: MoviesDetail.Detail.ViewModel)
    func showError(_ errorMessage: String)
    func isLoadingMovieDetail(loading status: Bool)
}

class MoviesDetailViewController: UIViewController, MoviesDetailDisplayLogic {
    
    @IBOutlet fileprivate weak var loadingView: UIView!
    @IBOutlet fileprivate weak var movieTitleLabel: UILabel!
    @IBOutlet fileprivate weak var movieRatingLabel: UILabel!
    @IBOutlet fileprivate weak var movieDurationLabel: UILabel!
    @IBOutlet fileprivate weak var movieBudgetLabel: UILabel!
    @IBOutlet fileprivate weak var movieReleaseDateLabel: UILabel!
    @IBOutlet fileprivate weak var movieOverviewLabel: UILabel!
    @IBOutlet fileprivate weak var movieGenresLabel: UILabel!
    @IBOutlet fileprivate weak var movieRevenueLabel: UILabel!
    @IBOutlet private weak var movieDetailsScrollView: UIScrollView! {
        didSet {
            movieDetailsScrollView.parallaxHeader.view = UIView()
            movieDetailsScrollView.parallaxHeader.minimumHeight = 0
            movieDetailsScrollView.parallaxHeader.mode = .topFill
            movieDetailsScrollView.parallaxHeader.height =  400
        }
    }
    
    
    
    var interactor: MoviesDetailBusinessLogic?
    var router: (NSObjectProtocol & MoviesDetailRoutingLogic & MoviesDetailDataPassing)?

    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        addBackButton()
        self.title = "Details"
        self.view.addSubview(loadingView)
        fetchMovieDetail()
    }
    
    // MARK: Fetch Movie Detail
        
    func fetchMovieDetail() {
        isLoadingMovieDetail(loading: true)
        guard let movieId = router?.dataStore?.selectedMovieId else {return}
        let request = MoviesDetail.Detail.Request(movieId: movieId)
        interactor?.fetchMovieDetail(request: request)
    }
    
    // MARK: Setup Movie Detail
    func setupMovieDetails(_ details: MoviesDetail.Detail.ViewModel) {
        isLoadingMovieDetail(loading: false)
        self.movieTitleLabel.text = details.title
        self.movieRatingLabel.text = details.rating
        self.movieBudgetLabel.text = details.budget
        self.movieReleaseDateLabel.text = details.releaseDate
        self.movieOverviewLabel.text = details.overview
        self.movieRevenueLabel.text = details.revenue
        self.movieGenresLabel.text = details.genere
        self.movieDurationLabel.text = details.runtime
        
        setCoverPath(coverImage:details.backdropPath)
    }
    
    fileprivate func setCoverPath(coverImage:String) {
        guard let url = URL(string: coverImage) else {return}
        
        UIImageView().af.setImage(withURL: url, placeholderImage: UIImage.placeholderImage, filter: .none, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true){[weak self] (img:AFIDataResponse<UIImage>) in
            let posterImage = UIImageView(image: img.value)
            posterImage.contentMode = .scaleAspectFill
            posterImage.alpha = 0
            self?.movieDetailsScrollView.parallaxHeader.view = posterImage
            UIView.animate(withDuration: 0.3, animations: {
                self?.movieDetailsScrollView.parallaxHeader.view.alpha = 1
            })
        }
    }

    
    func showError(_ errorMessage: String) {
        
    }
    
    func isLoadingMovieDetail(loading status: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView.alpha = status ? 1 : 0
            })
        }
    }
}
