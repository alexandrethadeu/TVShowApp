//
//  TVShowAppApp.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import SwiftUI

@main
struct TVShowAppApp: App {
    // register injection every launc
    init() {
        Injector.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
           TVShowList()
        }
    }
}
