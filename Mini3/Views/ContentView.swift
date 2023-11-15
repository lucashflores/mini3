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

    
    var body: some View {
        ToursView()
    }

    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//#Preview {
//    
//    ContentView()
//        .environment(\.managedObjectContext, persistenceController.container.viewContext)
//}
