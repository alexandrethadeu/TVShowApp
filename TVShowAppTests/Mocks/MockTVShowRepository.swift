//
//  MockTVShowRepository.swift
//  TVShowAppTests
//
//  Created by Alexandre Thadeu  on 29/06/22.
//

import Foundation
@testable import TVShowApp

class MockTVShowRepository: TVShowRepositoryProtocol {
    var remote: TVShowRemoteProtocol
    
    init(remote: TVShowRemoteProtocol) {
        self.remote = remote
    }
    
    func fetchTopRatedTVShow(page: Int) async throws -> [TVShowApp.TVShow] {
        let tvShowNetworkResponse = try await remote.fetchTopRatedShowsAF(page: page)
        return tvShowNetworkResponse.results
    }
}
