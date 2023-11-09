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
            ToursView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(TourManager(controller: persistenceController))
                .environmentObject(PlacesManager(controller: persistenceController))
//                .environmentObject(EnvelopeListManager())
//                .navigationBarBackButtonHidden(true)
//                .preferredColorScheme(.light)
        }
    }
}
