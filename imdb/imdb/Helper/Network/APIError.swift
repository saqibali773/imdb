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
                return "Something went wrong please try again."
        }
    }
}
