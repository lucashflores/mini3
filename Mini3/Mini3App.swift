//
//  Mini3App.swift
//  Mini3
//
//  Created by Lucas Flores on 06/11/23.
//

import SwiftUI

@main
struct Mini3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
