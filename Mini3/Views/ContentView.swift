//
//  ContentView.swift
//  Mini3
//
//  Created by Lucas Flores on 06/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let persistenceController = PersistenceController.shared
    @State var hasSeenOnboarding = UserDefaults.standard.bool(forKey: "HasSeenOnboarding")

    
    var body: some View {
        if (!hasSeenOnboarding) {
            OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                .preferredColorScheme(.light)
        }
        else {
            ToursView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(TourManager(controller: persistenceController))
                .environmentObject(PlacesManager(controller: persistenceController))
                .preferredColorScheme(.light)
        }
    }

    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
