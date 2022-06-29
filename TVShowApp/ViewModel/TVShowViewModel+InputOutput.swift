//
//  TVShowViewModel+InputOutput.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

extension TVShowViewModel {
    enum Input {
        case onAppear
        case refreshTVShow
    }
    
    struct Output {
        var tvShows: [TVShow] = []
        var isLoadMore: Bool = false
        var isLoading: Bool = false
        var errors: Errors = .noError
        
        enum Errors {
            case noError
            case decodeError
            case networkError
        }
    }
}
