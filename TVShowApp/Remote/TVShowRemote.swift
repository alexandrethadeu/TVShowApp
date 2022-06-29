//
//  TVShowRemote.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation
import Alamofire

class TVShowRemote: TVShowRemoteProtocol {
    
    func fetchTopRatedShows(page: Int) async throws -> TVShowNetworkResponse {
        let request = TVShowRemote.Route.getTopRatedShows(page: page).request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw Errors.badRequest
        }
        
        print("Request to: \(httpResponse.url!)")
                
        guard
            let decodedResponse = try? JSONDecoder()
                .decode(TVShowNetworkResponse.self, from: data)
        else {
            throw Errors.decodeFailed
        }
        
        return decodedResponse
       
    }
    
    func fetchTopRatedShowsAF(page: Int) async throws -> TVShowNetworkResponse {
        let request = TVShowRemote.Route.getTopRatedShows(page: page).request
        let dataTask = sessionManager
            .request(request)
            .validate()
            .serializingDecodable(TVShowNetworkResponse.self)
        
        let result = await dataTask.result
      
        switch result {
            case .success(let successData):
                return successData
            case .failure(let afError):
                throw afError
        }
    }
}

