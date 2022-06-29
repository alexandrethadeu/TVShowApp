//
//  Injector.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/06/22.
//

import Foundation
import Swinject

struct Injector {
    static let shared = Injector()
    let container = Container()
    
    func register() {
        registerRemote()
        registerRepository()
    }
    
    private func registerRemote() {
        container.register(TVShowRemoteProtocol.self) {  _ in TVShowRemote() }
    }
    
    private func registerRepository() {
        container.register(TVShowRepositoryProtocol.self) { resolver in
            TVShowRepository(remote: resolver.resolve(TVShowRemoteProtocol.self)!)
        }
    }
}
