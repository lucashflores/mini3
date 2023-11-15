//
//  PointsView.swift
//  Mini3
//
//  Created by Andrea Oquendo on 09/11/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct PointsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var tourManager: TourManager
    @EnvironmentObject var placesManager: PlacesManager
    
    let tourId: UUID
    
    @State private var placeModels: [PlaceModel] = []
    @State private var placeName: String = ""
    
    @State private var draggingItem: String? = ""
    @State private var isEditMode = false
    @State private var isImageVisible = false
    
    let backgroundColors: [Color] = [Color.itiAzul, Color.itiAzulEscuro, Color.itiAlaranjado]
    
    var body: some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: -16){
                    Text("Your tour")
                        .font(Font.appTitle)
                    Text("notes")
                        .font(Font.appBoldTitle)
                }
                .padding(.horizontal, 16)
                .foregroundColor(Color.black)
                
                Text(getTourName())
                    .padding(.horizontal, 16)
                    .font(Font.appSubTitle)
                    .foregroundColor(Color.subTitleColor)
            }
            
//            TextField("Enter tour name: ", text: $placeName)
//            Button {
//                addPlace()
//            } label: {
//                Text("adicionar")
//            }
            
            VStack(spacing: 10) {
                HStack(){
                    Spacer()
                    Button{
                        isEditMode.toggle()
                        withAnimation {
                            
                            isImageVisible.toggle() // Toggle the visibility with animation
                        }
                    } label: {
                        if isEditMode {
                            Text("Save")
                        } else {
                            Text("Edit")
                        }
                    }
                    .foregroundStyle(.blue)
                }
                .padding(.horizontal, 16)
                
                ScrollView(.vertical){
                    LazyVGrid(columns: [GridItem()]){
                        ForEach(Array(placeModels.enumerated()), id: \.element.id) { index, place in
                            
                            if isEditMode {
                                PlaceItem(place: place, backgroundColor: backgroundColors[index % backgroundColors.count])
                                    .draggable(place.name){
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.ultraThinMaterial)
                                            .frame(width: 1, height: 1)
                                            .onAppear{
                                                draggingItem = place.name
                                            }
                                    }
                                    .dropDestination(for: String.self){ items, location in
                                        draggingItem = nil
                                        return false
                                    } isTargeted: { status in
                                        if status && draggingItem != place.name {
                                            if let  sourceIndex = placeModels.firstIndex(where: {$0.name == draggingItem}),
                                               let destinationIndex = placeModels.firstIndex(where: {$0.name == place.name}){
                                                withAnimation(.bouncy){
                                                    let sourceItem = placeModels.remove(at:sourceIndex)
                                                    placeModels.insert(sourceItem, at: destinationIndex)
                                                }
                                            }
                                        }
                                    }
                            } else {
                                PlaceItem(place: place, backgroundColor: backgroundColors[index % backgroundColors.count])
                            }
                            
                        }
                    }
                    .padding(.horizontal, 12)
                    
                    
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            
            
        }
//        .padding(10)
       .onAppear {
           update()
       }
       .accentColor(.black)
//       .navigationTitle("Add Stops")
        
    }
    
    func addPlace(){
//        let newPlace = PlaceModel(name: placeName, orderNumber: -1, tourId: tourId, title: place.title ?? "",
//                                  latitude: place.latitude,
//                                  longitude: place.longitude)
//        placesManager.createPoint(place: newPlace, allPlaces: placeModels)    
//        update()
//        
    }
    
    func deletePlace(id: UUID){
        placesManager.deleteplace(placeId: id)
        update()
    }
    
    func editPlace(id: UUID, name: String?){
        placesManager.editPlace(id: id, name: name)
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
    
    func PlaceItem(place: PlaceModel, backgroundColor: Color) -> some View {
        HStack {
            VStack(alignment: .leading){
                Text(place.name)
                    .font(.system(size: 22))
                Text("No notes yet")
                    .font(.system(size: 15))
                Spacer()
            }
            .padding(.top, 16)
            
            Spacer()
            
            if isEditMode {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 32))
                    .opacity(isImageVisible ? 1 : 0) // Initial opacity set based on isImageVisible
                    .animation(.easeInOut)
            }
            
            
        }
        .foregroundColor(Color.texto)
        .padding(.horizontal)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(23)
//        .frame(height: 100)
    }
    
    func PlaceItemDraggable(place: PlaceModel) -> some View {
        HStack {
            VStack(alignment: .leading){
                Text(place.name)
                    .font(.system(size: 22))
                Text("No notes yet")
                    .font(.system(size: 15))
                Spacer()
            }
            
            Spacer()
            
            
        }
        .padding(.top, 16)
        .foregroundColor(Color.texto)
        .padding(.horizontal)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        
        .background(Color.itiAzul)
        .cornerRadius(23)
//        .frame(height: 100)
    }
    
    private func getTourName() -> String {
        return tourManager.getTourName(tourId: tourId)
    }
    
    
}

struct DropViewDelegate: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
}

#Preview {
    ToursView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(TourManager(controller: PersistenceController.shared))
        .environmentObject(PlacesManager(controller: PersistenceController.shared))
}
