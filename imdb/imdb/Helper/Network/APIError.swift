//
//  APIError.swift
//
//  Created by Saqib Ali on 17/04/2022.
//

import Foundation

enum APIError: Error {
    case parseError
    
    public var errorDescription: String? {
        switch self {
            case .parseError:
            return "No Search result found with this keyword, Please try with some other word."
        }
    }
}
