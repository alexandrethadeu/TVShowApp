//
//  TVShowRepositoryProtocol.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/06/22.
//

import Foundation

protocol TVShowRepositoryProtocol {
    func fetchTopRatedTVShow(page: Int) async throws -> [TVShow]
}
