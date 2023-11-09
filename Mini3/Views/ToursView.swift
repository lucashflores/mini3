//
//  ToursView.swift
//  Mini3
//
//  Created by Andrea Oquendo on 07/11/23.
//

import SwiftUI

struct ToursView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var tourManager: TourManager
    
    @State private var tourModels: [TourModel] = []
    @State private var tourName: String = ""
    
    
    var body: some View {
       NavigationStack {
           
           TextField("Enter tour name: ", text: $tourName)
           Button {
               addTour()
           } label: {
               Text("adicionar")
           }
           
           List(tourModels, id: \.id) { tour in
               NavigationLink(destination: PointsView(tourId: tour.id)) {
                   Text(tour.name)
               }
           }
           .onAppear {
               
               // Fetch the TourModels when the view appears
               tourModels = tourManager.fetchAllTourModels()
           }
       }
    }
    
    func addTour(){
        let newTour = TourModel(name: tourName)
        tourManager.createTour(tour: newTour)
        update()
        
    }
    
    func deleteTour(id: UUID){
        tourManager.deleteTour(tourId: id)
        update()
    }
    
    func editTour(id: UUID, name: String?){
        tourManager.editTour(id: id, name: name)
        update()
    }
    
    func update() {
        
        tourModels = tourManager.fetchAllTourModels()
    }
}

#Preview {
    ToursView()
}
