//
//  String.swift
//  imdb
//
//  Created by Saqib Ali on 17/04/2022.
//

import Foundation

extension String {
    
    enum ImageQuality: String {
        case low = "200", high = "500", original = "original"
    }
    
    func getImageURL(quality imageQuality: ImageQuality) -> String {
        switch imageQuality {
            case .low,.high:
                return "https://image.tmdb.org/t/p/w\(imageQuality.rawValue)\(self)"
            case .original:
                return "https://image.tmdb.org/t/p/\(imageQuality.rawValue)\(self)"
        }
    }
}
