//
//  marvelProjectApp.swift
//  marvelProject
//
//  Created by Marta Maquedano on 29/3/23.
//

import SwiftUI

@main
struct marvelProjectApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject
    var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(rootViewModel)
        }
    }
}
