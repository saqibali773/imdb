//
//  MoviesDetailWorker.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.

import UIKit

protocol FetchingMovieDetailUsecase {
    func fetchMovieDetail(request: MoviesDetail.Detail.Request,
                           completion: @escaping (Result<MoviesDetail.Detail.Response, Error>) -> Void)
}

class MoovieDetailWorker:FetchingMovieDetailUsecase {
    
    let service : NetworkService
    let decoder = JSONDecoder()
    
    init(service:NetworkService) {
        self.service = service
    }
    
    func fetchMovieDetail(request: MoviesDetail.Detail.Request, completion: @escaping (Result<MoviesDetail.Detail.Response, Error>) -> Void) {
        guard let movieId = request.movieId else {return}
        let networkConfig:NetworkConfig = DefaultConfig.shared
        let url = APIUrls.getURL(for: .movie(movieId: movieId), urlConfig: networkConfig, queryItems: nil)
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
                        let response = try JSONDecoder().decode(MoviesDetail.Detail.Response.self, from: jsonData)
                        completion(.success(response))
                    } catch {
                        completion(.failure(APIError.parseError))
                    }
                case .failure(let errorResponse):
                    completion(.failure(errorResponse.error))
            }
            
        }
    }
    
}
