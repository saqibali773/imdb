//
//  MoviesDetailPresenter.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

protocol MoviesDetailPresentationLogic {
    func presentMovieResponse(response: MoviesDetail.Detail.MovieDetailModel)
}

class MoviesDetailPresenter: MoviesDetailPresentationLogic {
    weak var viewController: MoviesDetailDisplayLogic?
    
    // MARK: Do something
    
    func presentMovieResponse(response: MoviesDetail.Detail.MovieDetailModel) {
        var viewModel = MoviesDetail.Detail.ViewModel()
        
        
        viewModel.releaseDate = response.releaseDate
        viewModel.genere = response.genres.map {$0.name}.joined(separator: ", ")
        viewModel.revenue = "$ \(response.revenue.withCommas())"
        viewModel.budget = "$ \(response.budget.withCommas())"
        viewModel.overview = response.overview
        viewModel.title = response.title
        viewModel.rating = String(format: "%.1f", response.voteAverage)
        if let minutes = response.runtime {
            let formatedTime = self.minutesToHoursMinutes(minutes: minutes)
            viewModel.runtime = "\(formatedTime.hours):\(formatedTime.leftMinutes) h"
        } else {
            viewModel.runtime = "unavailable"
        }
        if let posterPath = response.posterPath {
            viewModel.posterPath = posterPath.getImageURL(quality: .high)
        }
        if let backdropPath = response.backdropPath {
            viewModel.backdropPath = backdropPath.getImageURL(quality: .original)
        }
        viewController?.setupMovieDetails(viewModel)
    }
    
    fileprivate func minutesToHoursMinutes(minutes: Int) -> (hours: Int, leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
}
