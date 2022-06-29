//
//  TVShowRepository.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

class TVShowRepository: TVShowRepositoryProtocol {
    let remote: TVShowRemoteProtocol
    
    init(remote: TVShowRemoteProtocol) {
        self.remote = remote
    }
    
    func fetchTopRatedTVShow(page: Int) async throws -> [TVShow] {
        let tvShowNetworkResponse = try await remote.fetchTopRatedShowsAF(page: page)
        return tvShowNetworkResponse.results
    }
}
