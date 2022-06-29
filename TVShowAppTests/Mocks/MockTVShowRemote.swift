//
//  MockTVShowRemote.swift
//  TVShowAppTests
//
//  Created by Alexandre Thadeu  on 29/06/22.
//

import Foundation
@testable import TVShowApp

final class MockTVShowRemote: TVShowRemoteProtocol, Mockable {
    
    func fetchTopRatedShows(page: Int) async throws -> TVShowApp.TVShowNetworkResponse {
        return loadJSON(filename: "TVShowResponse", type: TVShowApp.TVShowNetworkResponse.self)
    }
    
    func fetchTopRatedShowsAF(page: Int) async throws -> TVShowApp.TVShowNetworkResponse {
        return loadJSON(filename: "TVShowResponse", type: TVShowApp.TVShowNetworkResponse.self)
    }

}
