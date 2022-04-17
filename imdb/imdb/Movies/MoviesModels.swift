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
            var total_pages: Int
            var total_results: Int
            var results: [Movie]
        }
        
        struct Movie: Codable {
            
        }
        
        struct ViewModel {
            
        }
    }
}

