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
           
           List{
               ForEach(placeModels, id: \.id) { place in
                   Text(place.name)
               }
               .onMove(perform: move)
           }
           .toolbar {
               EditButton()
           }
           
       }
       .onAppear {
           
           update()
       }
       .navigationTitle("Add Stops")
        
    }
    
    func addPlace(){
        let newPlace = PlaceModel(name: placeName, orderNumber: -1, tourId: tourId)
        placesManager.createPoint(place: newPlace, allPlaces: placeModels)
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
    
    private func update() {
        placeModels = placesManager
            .fetchAllPlaceByTour(tourId: tourId)
            .sorted(by: { $0.orderNumber < $1.orderNumber })
    }
    
    func move(from source: IndexSet, to destination: Int) {
        placeModels.move(fromOffsets: source, toOffset: destination)
        placesManager.saveOrder(placesList: placeModels, tourId: tourId)
    }
    
    
}

#Preview {
    ToursView()
}
