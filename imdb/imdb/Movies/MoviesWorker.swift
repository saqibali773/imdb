//
//  MoviesWorker.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.


import UIKit
import network

protocol FetchMoviesUsecase {
    func fetchMoviesList(request: Movies.Movie.Request,completion: @escaping (Result<Movies.Movie.Response, Error>) -> Void)
}

class MoviesWorker:FetchMoviesUsecase {
    let service : NetworkService = Network()
    
    func fetchMoviesList(request: Movies.Movie.Request,completion: @escaping (Result<Movies.Movie.Response, Error>) -> Void) {
        var queryParams = request.getQueryParams()
        let networkConfig:NetworkConfig = DefaultConfig.shared
        let apiKey :String = networkConfig.imdb.apiKey
        queryParams.append(URLQueryItem(name: "api_token", value: apiKey))
        let url = APIUrls.getURL(for: .discover, urlConfig: networkConfig, queryItems: queryParams)
        let apiRequest = APIRequest(url: url, methodType: .get, params: nil)
        
        service.execute(request: apiRequest.urlRequestWithHeaders(type: .JSON)) { response in
            switch response {
                case .success(let successResponse):
                    guard let dict = successResponse.result as? [String:Any],
                          let jsonData = try? JSONSerialization.data(withJSONObject:dict) else {
                        completion(.failure(APIError.parseError))
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(Movies.Movie.Response.self, from: jsonData)
                        completion(.success(response))
                    } catch {
                        completion(.failure(APIError.parseError))
                    }
                case .failure(let failureResponse):
                    completion(.failure(failureResponse.error))
                    
            }
        }
    }
}
