//
//  MoviesDetailModels.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import UIKit

enum MoviesDetail {
    // MARK: Use cases
    
    enum Detail {
        struct Request {
            let movieId :Int?
        }
        
        struct MovieDetailModel: Codable {
            let adult: Bool
            let backdropPath: String?
            let belongsToCollection: BelongsToCollection?
            let budget: Int
            let genres: [Genre]
            let homepage: String?
            let movieID: Int
            let imdbID: String?
            let originalLanguage, originalTitle, overview: String
            let popularity: Double
            let posterPath: String?
            let releaseDate: String
            let runtime: Int?
            let revenue: Int
            let spokenLanguages: [SpokenLanguage]
            let status, tagline, title: String
            let video: Bool
            let voteAverage: Double
            let voteCount: Int
            
            enum CodingKeys: String, CodingKey {
                case adult
                case backdropPath = "backdrop_path"
                case belongsToCollection = "belongs_to_collection"
                case budget, genres, homepage
                case movieID = "id"
                case imdbID = "imdb_id"
                case originalLanguage = "original_language"
                case originalTitle = "original_title"
                case overview, popularity
                case posterPath = "poster_path"
                case releaseDate = "release_date"
                case runtime, revenue
                case spokenLanguages = "spoken_languages"
                case status, tagline, title, video
                case voteAverage = "vote_average"
                case voteCount = "vote_count"
            }
        }
        
        struct BelongsToCollection: Codable {
            let collectionID: Int
            let backdropPath: String?
            let posterPath: String?
            let name: String
            
            enum CodingKeys: String, CodingKey {
                case collectionID = "id"
                case backdropPath = "backdrop_path"
                case posterPath = "poster_path"
                case name
            }
        }
        
        struct Genre: Codable {
            let genreID: Int
            let name: String
            
            enum CodingKeys: String, CodingKey {
                case name
                case genreID = "id"
            }
        }
        
        struct SpokenLanguage: Codable {
            let identifier, name: String
            
            enum CodingKeys: String, CodingKey {
                case identifier = "iso_639_1"
                case name
            }
        }
        
        
        struct ViewModel {
            var overview: String?
            var runtime: String?
            var revenue: String?
            var budget: String?
            var title: String?
            var posterPath: String = ""
            var backdropPath: String = ""
            var releaseDate: String = ""
            var genere: String?
            var rating: String?
        }
        
    }
}
