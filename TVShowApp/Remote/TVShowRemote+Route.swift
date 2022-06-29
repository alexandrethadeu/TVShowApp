//
//  TVShowRemote+Route.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

extension TVShowRemote {
    enum Route: NetworkRoute {
        case getTopRatedShows(page: Int)
        
        var baseUrlString: String {
            return "api.themoviedb.org"
        }
        
        var path: String {
            return "/3/tv/popular"
        }
        
        var httpMethod: HTTPMethod {
            return .get
        }
        
        var headers: Headers {
            ["Content-Type": "application/x-www-form-urlencoded"]
        }
        
        var parameters: Parameters {
            switch self {
            case .getTopRatedShows(let page):
                return    [
                    "api_key": "37d31119cfbe80b2c7ef01cf3735ea2b",
                    "language": "en-US",
                    "page": "\(page)"
                ]
            }
         
        }
    }
}
