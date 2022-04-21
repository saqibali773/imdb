//
//  MovieListMockWorker.swift
//  imdbTests
//
//  Created by Saqib Ali on 22/04/2022.
//

import XCTest
@testable import imdb

class MovieListMockWorker: FetchMoviesUsecase {
    let jsonFileName: String
  
    init(fileName: String) {
        self.jsonFileName = fileName
    }
    
    func fetchMoviesList(request: Movies.Movie.Request, completion: @escaping (Result<Movies.Movie.Response, Error>) -> Void) {
        do {
            guard let localPath = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json") else {
                completion(.failure(APIError.parseError))
                return
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: localPath))
            let museumResponse = try JSONDecoder().decode(Movies.Movie.Response.self, from: data)
            completion(.success(museumResponse))
        } catch (let error) {
            completion(.failure(error))
        }
    }

}


