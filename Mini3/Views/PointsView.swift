//
//  PointsView.swift
//  Mini3
//
//  Created by Andrea Oquendo on 09/11/23.
//

import SwiftUI

struct PointsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var tourManager: TourManager
    @EnvironmentObject var placesManager: PlacesManager
    
    let tourId: UUID
    
    @State private var placeModels: [PlaceModel] = []
    @State private var placeName: String = ""
    
    
    var body: some View {
       VStack {
           
           TextField("Enter tour name: ", text: $placeName)
           Button {
               addPlace()
           } label: {
               Text("adicionar")
           }
           
           List(placeModels, id: \.id) { tour in
               Text(tour.name)
//                   .onLongPressGesture{
//                       editPlace(id: tour.id, name: "hola")
//                       
//                   }
           }
           .onAppear {
               
               // Fetch the TourModels when the view appears
               placeModels = placesManager.fetchAllPlaceByTour(tourId: tourId)
           }
       }
    }
    
    func addPlace(){
        let newPlace = PlaceModel(name: placeName, tourId: tourId)
        placesManager.createPoint(place: newPlace)
        update()
        
    }
    
    func deletePlace(id: UUID){
        placesManager.deleteplace(placeId: id)
        update()
    }
    
    func editPlace(id: UUID, name: String?){
        placesManager.editplace(id: id, name: name)
        update()
    }
    
    func update() {
        placeModels = placesManager.fetchAllPlaceByTour(tourId: tourId)
    }
}

#Preview {
    ToursView()
}
