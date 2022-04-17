//
//  NetworkConfig.swift
//
//  Created by Saqib Ali on 17/04/2022.
//

import Foundation

public protocol NetworkConfig {
    var imdb: APIEndpoint { get set }
}

public struct APIEndpoint {
    public let url: String
    public let headers: [String: Any]
    public let apiKey: String
    
    public init(url: String, headers: [String: String],apiKey:String) {
        self.url = url
        self.headers = headers
        self.apiKey = apiKey
    }
}

public class DefaultConfig: NetworkConfig {
    public static let shared = DefaultConfig()
    private init() {}
        
    public var imdb = APIEndpoint(url: "https://api.themoviedb.org/3/",
                                    headers: [:],
                                    apiKey: "c9856d0cb57c3f14bf75bdc6c063b8f3")
}



