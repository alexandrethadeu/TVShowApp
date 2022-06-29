//
//  TVShowRemote+Errors.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

extension TVShowRemote {
    enum Errors: Error {
        case unAuthorized
        case notFound
        case badRequest
        case decodeFailed
    }
}
