//
//  MoviesModels.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

enum Movies {
    // MARK: Use cases
    enum Movie {
        struct Request {
            var page:Int = 0
            init(page: Int = 0) {
                self.page = page
            }
            func getQueryParams() -> [URLQueryItem] {
                let items = [ URLQueryItem(name: "page", value: String(page))]
                return items
            }
        }
        
        struct Response: Codable {
            var page: Int
            var totalPages: Int
            var totalResults: Int
            var results: [MovieModel]
            
            enum CodingKeys: String, CodingKey {
                case page
                case totalResults = "total_results"
                case totalPages = "total_pages"
                case results = "results"
            }
        }
        
        struct MovieModel: Codable {
            let voteCount: Int
            let movieID: Int
            let voteAverage: Double
            let title: String
            let popularity: Double
            let posterPath: String?
            let originalTitle: String
            let backdropPath: String?
            let overview, releaseDate: String
            
            enum CodingKeys: String, CodingKey {
                case voteCount = "vote_count"
                case movieID = "id"
                case voteAverage = "vote_average"
                case title, popularity
                case posterPath = "poster_path"
                case originalTitle = "original_title"
                case backdropPath = "backdrop_path"
                case overview
                case releaseDate = "release_date"
            }
        }
        
        struct ViewModel {
            var page: Int = 0
            var nextPage: Int = 0
            var shouldLoadMore : Bool = false
            var movies:[MovieViewModel] = []
            
            struct MovieViewModel {
                var movieId:Int
                var title:String
                var rating:String
                var releaseYear:String
                var description:String
                var posterPath:String
            }
        }
    }
}

