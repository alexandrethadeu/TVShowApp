//
//  TVShowRemoteProtocol.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/06/22.
//

import Foundation

protocol TVShowRemoteProtocol {
    func fetchTopRatedShows(page: Int) async throws -> TVShowNetworkResponse
    func fetchTopRatedShowsAF(page: Int) async throws -> TVShowNetworkResponse
}
