//
//  APIRequest.swift
//
//

import Foundation
import network

struct APIRequest {
    
    let url: URL
    let methodType: HTTPMethod
    let params: Any?
    
    func urlRequestWithHeaders(type: HeaderType) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        switch type {
        case .JSON:
            request.allHTTPHeaderFields = [
                "Content-Type":"application/json",
                "Accept":"application/json",
                
            ]
        case .XML:
            request.setValue("XMLHttpRequest", forHTTPHeaderField: "x-requested-with")
        case .textHtml:
            request.setValue("text/html", forHTTPHeaderField: "Accept")
        case .textPlain:
            request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        
        request.httpShouldHandleCookies = true
        
        if let param = params {
            do{
                let paramsData = try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpBody = paramsData
            } catch{}
        }
        
        return request
    }
    
    enum HeaderType {
        case JSON
        case XML
        case textHtml
        case none
        case textPlain
    }
    
}
