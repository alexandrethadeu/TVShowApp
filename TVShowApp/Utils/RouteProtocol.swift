//
//  RouteProtocol.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

protocol NetworkRoute {
    typealias Parameters = [String: Any]
    typealias Headers = [String: String]
    
    var baseUrlString: String { get }
    var path: String  { get }
    var httpMethod: HTTPMethod { get }
    var headers: Headers { get }
    var parameters: Parameters { get }
}

extension NetworkRoute {
    var url: URL {
        return components.url!
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrlString
        components.path = path
        
        if httpMethod == .get {
            components.queryItems = parameters.map({ (key: String, value: Any) in
                return URLQueryItem(name: key, value: value as? String)
            })
        }
        
        return components
    }
    
    var request: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.httpMethod.rawValue
        request.allHTTPHeaderFields = self.headers
        
        return request
    }
}
