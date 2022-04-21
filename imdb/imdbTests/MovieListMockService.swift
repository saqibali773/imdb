//
//  MovieListMockService.swift
//  imdbTests
//
//  Created by Saqib Ali on 22/04/2022.
//

import XCTest
@testable import imdb


class MockNetwork: NetworkService {
    
    let jsonFileName: String
    
    init(fileName: String) {
        self.jsonFileName = fileName
    }
    
    func execute(request: URLRequest, callback: @escaping (NetworkResponse) -> Void) {
        do {
            guard let localPath = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json") else {
                callback(.failure(FailureResponse(error: APIError.parseError, response: nil)))
                return
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: localPath))
            let result =  try JSONSerialization.jsonObject(with: data, options: []) 
            callback(.success(SuccessResponse(result: result, response: nil)))

        } catch  {
            callback(.failure(FailureResponse(error: APIError.parseError, response: nil)))
        }
    }

}


