//
//  NetworkService.swift
//  Network
//.
//

import Foundation
import Alamofire


public struct SuccessResponse {
    public let result: Any
    public let response: HTTPURLResponse?
}

public struct FailureResponse {
    public let error: Error
    public let response: HTTPURLResponse?
}

public enum NetworkResponse {
    case success(SuccessResponse)
    case failure(FailureResponse)
    
    public var statusCode: Int {
        switch self {
        case .success(let urlRes):
            return urlRes.response?.statusCode ?? -1
        case .failure(let urlRes):
            return urlRes.response?.statusCode ?? -1
        }
    }
}

public protocol NetworkService {
    func execute(request: URLRequest, callback: @escaping (NetworkResponse) -> Void)
}

public class Network: NSObject {
    
    public var isConnected: Bool {
        return NetworkReachabilityManager.default?.isReachable ?? false
    }
    
    lazy var alamoFire: Session = {
        let manager = Alamofire.Session.default
        manager.session.configuration.httpCookieAcceptPolicy = .always
        manager.session.configuration.httpShouldSetCookies = true
        return manager
    }()
}

extension Network: NetworkService {
    public func execute(request: URLRequest, callback: @escaping (NetworkResponse) -> Void) {
        
        if !isConnected {
            callback(.failure(FailureResponse(error: APIError.internetUnavailable, response: nil)))
            return
        }
        alamoFire.cancelAllRequests()
        alamoFire.request(request).responseJSON { (dataResponse) in
            
            let code =  dataResponse.response?.statusCode ?? 0
            switch dataResponse.result {
            case .success(let json):
                if 200..<300 ~= code {
                    callback(.success(SuccessResponse(result: json, response: dataResponse.response)))
                } else {    
                    if let serverError = APIError.parseServerError(for: code, data: json) {
                        callback(.failure(FailureResponse(error: serverError, response: dataResponse.response)))
                        return
                    }
                    callback(.failure(FailureResponse(error: APIError.unknown, response: dataResponse.response)))
                }
            case .failure(let error):
                guard !error.isExplicitlyCancelledError else {
                    return
                }
                callback(.failure(FailureResponse(error: APIError.unknown, response: dataResponse.response)))
            }
        }
    }
}


extension Network {
    public enum APIError: Error, LocalizedError {
    
        case internetUnavailable
        case parseError
        case other(description: String)
        case serverError(code: Int, message: String)
        case unknown
        
        public var errorDescription: String? {
            switch self {
            case .internetUnavailable:
                return "Please check your internet"
            case .parseError:
                return "Data cannot be parsed"
            case .other(let description):
                return description
            case .serverError(_, let message):
                return message
            case .unknown:
                return "Unknown error occurred. Please try again later."
            }
        }
        
        
        static func parseServerError(for code: Int, data: Any) -> APIError? {
            var description : String?
            if let json = data as? [String:Any], let errors = json["errors"] as? [String:Any] {
                if let messages = errors["message"] as? [String], let message = messages.first {
                    description = message
                } else if let key = errors.keys.first {
                    if let messages = errors[key] as? NSArray,let message = messages.firstObject as? String {
                        description = message
                    } else {
                        if let message = errors[key] as? String {
                            description = message
                        }
                    }
                }
            }
            
            if let json = data as? [String:Any], let errors = json["list_item"] as? [String] {
                description = errors.first
            } else if let json = data as? [String:Any], let error = json["message"] as? String {
                description = error
            }
            guard let errorDescription = description else {
                return nil
            }
            return APIError.serverError(code: code, message: errorDescription)
        }
    }
}
