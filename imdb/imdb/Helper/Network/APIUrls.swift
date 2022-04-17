//
//  APIUrls.swift
//

import UIKit


enum URLType: Equatable {
    case discover
    case movie(movieId:Int)
    var value: String {
        switch self {
            case .discover:
                return "/discover/movie"
            case .movie(let movieId):
                return "movie/\(movieId)"
        }
    }
}

class APIUrls: NSObject {
    
    class func getURL(for type: URLType, urlConfig: NetworkConfig, queryItems: [URLQueryItem]?) -> URL {
        let urlString = urlConfig.imdb.url + type.value
        var components = URLComponents(string: urlString)
        components?.queryItems = queryItems
        
        return components!.url!
    }
    
}
