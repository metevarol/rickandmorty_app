//
//  rickandmortyApp.swift
//  rickandmorty
//
//  Created by Mete Varol on 17.04.2023.
//

import SwiftUI

@main
struct rickandmortyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.colorScheme, .light)
        }
    }
}
