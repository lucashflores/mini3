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
    
    @State private var tourName: String = ""
    @State private var categorySelected: String = ""
    
    @State private var placeModels: [PlaceModel] = []
    @State private var placeName: String = ""
    
    @State private var category: String = ""
    
    @State private var draggingItem: String? = ""
    @State private var isEditMode = false
    @State private var editNameSheet = false
    @State private var isImageVisible = false
    
    @State private var categoryAvailable = true
    
    @State private var selectedHighlight: PlaceModel = PlaceModel(name: "padrao", orderNumber: 0, title: "", latitude: 1, longitude: 1)
    
    @State private var noteSheet = false
    let backgroundColors: [Color] = [Color.itiAzul, Color.itiAzulEscuro, Color.itiAlaranjado]
    
    var body: some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: -8){
                    Text("Your tour")
                        .font(Font.appTitle)
                    Text("highlights")
                        .font(Font.appBoldTitle)
                }
                .padding(.horizontal, 16)
                .foregroundColor(Color.black)
                
                HStack(spacing: 10){
                    Text(tourName)
                        .font(Font.appSubTitle)
                        
                    Image(systemName: "pencil.line")
                        .onTapGesture {
                            editNameSheet = true
                        }
                        .font(.system(size: 26))
                }
                .foregroundColor(Color.subTitleColor)
                .padding(.horizontal, 16)
                
//                Text(tourManager.getTourCategory(tourId: tourId))
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
                        if isEditMode {
                            placesManager.saveOrder(placesList: placeModels, tourId: tourId)
                            update()
                        }
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
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                
                ScrollView(.vertical){
                    LazyVGrid(columns: [GridItem()]){
                        ForEach(Array(placeModels.enumerated()), id: \.element.id) { index, place in
                            
                            if isEditMode {
                                PlaceItem(place: place, backgroundColor: backgroundColors[index % backgroundColors.count]
                                )
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
                        NavigationLink(destination: MapView(tourId: tourId)){
                            AddPlace()
                        }
                        
                    }
                    .padding(.horizontal, 12)
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
            
            
        }
        .padding(.top, 16)
       .onAppear {
           category = tourManager.getTourCategory(tourId: tourId)
           update()
       }
       .sheet(isPresented: $noteSheet){
           NotesEditorView(sheet: $noteSheet, place: $selectedHighlight)
               .presentationDetents([.fraction(0.7)])
       }
       .sheet(isPresented: $editNameSheet){
           
               VStack(){
                   Text("Give your tour a name")
                       .font(.appBody)
                   
                   TextField("My Tour", text: $tourName)
                       .font(.largeTitle)
                       .multilineTextAlignment(.center)
                       .padding(20)
                   
                   VStack {
                       HStack(spacing: 2) {
                           CategoryNameTour(category: CategoryModel.categories[0].name, icon: CategoryModel.categories[0].icon, categorySelected: $categorySelected)
                           CategoryNameTour(category: CategoryModel.categories[1].name, icon: CategoryModel.categories[1].icon, categorySelected: $categorySelected)
                           CategoryNameTour(category: CategoryModel.categories[2].name, icon: CategoryModel.categories[2].icon, categorySelected: $categorySelected)
                       }
                       HStack(spacing: 2) {
                           CategoryNameTour(category: CategoryModel.categories[3].name, icon: CategoryModel.categories[3].icon, categorySelected: $categorySelected)
                           CategoryNameTour(category: CategoryModel.categories[4].name, icon: CategoryModel.categories[4].icon, categorySelected: $categorySelected)
                           CategoryNameTour(category: CategoryModel.categories[5].name, icon: CategoryModel.categories[5].icon, categorySelected: $categorySelected)
                       }
                   }
                   .padding(.bottom, 32)
                   
                   
                   Button("Save tour name") {
                       editNameSheet = false
                       tourManager.editTour(id: tourId, name: tourName, category: categorySelected)
//                       newTourId = addTour()
//                       isButtonTapped = true
                   }
                   .font(.appButton)
                   .padding()
                   
                   .background(Color("Alaranjado"))
                   .foregroundColor(.white)
                   .cornerRadius(30)
                   .padding(.top, 36)
               }
               .padding()
               .presentationDetents([.fraction(0.8), .large])
               .presentationDragIndicator(.visible)
               //           .interactiveDismissDisabled()
       }
       .accentColor(.black)
       .onChange(of: noteSheet) { newValue in
           if !newValue {
               // Sheet is closed, call your update function here
               update()
           }
       }
       .onAppear(){
           tourName = getTourName()
//           selectedCategory = 
       }
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
    
    func AddPlace() -> some View {
        VStack{
            HStack(alignment: .top){
                Text("Add a new highlight")
                    .font(.regularTextButton)
                    .foregroundColor(Color.textButton)
                    .padding(.top, 20)
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(Color.grayIcon)
                    .font(
                        Font.custom("SF Pro Display", size: 32)
                            .weight(.medium)
                    )
                    .padding(.top, 14)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 100)
        .background(Color.buttonBackground)
        .cornerRadius(23)
        
    }
    
    func PlaceItem(place: PlaceModel, backgroundColor: Color) -> some View {
        HStack {
            VStack(alignment: .leading){
                HStack(spacing: 10){
                    Image.appHighlighter
                        .resizable()
                        .frame(
                            width: 14,
                            height: 20
                        )
                        .foregroundColor(.white)
                        .padding(0)
                    Text(place.name)
                        .padding(0)
                        .font(.system(size: 22))
                }
                
                if (place.notes != nil) && place.notes!.isEmpty{
                    Text("No notes yet...")
                        .font(.system(size: 15))
                } else {
                    Text(place.notes ?? "No notes yet...")
                        .font(.system(size: 15))
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .lineLimit(1) // Limita o número de linhas
                        .truncationMode(.tail) // Adiciona reticências no final
                }
                
                Spacer()
            }
            .padding(.top, 18)
            
            Spacer()
            
            if isEditMode {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 32))
                    .opacity(isImageVisible ? 1 : 0) // Initial opacity set based on isImageVisible
//                    .animation(.smooth)
            } else {
                VStack{
                    Text("STOP \(place.orderNumber + 1)")
                        .font(.highlighterCount)
                        .foregroundColor(.white)
                        .frame(width: 80, height: 20)
                        .background(Color.stopBackground)
                        .cornerRadius(12)
                    
                    Spacer()
                }
                .padding(.top, 18)
            }
            
            
        }
        .foregroundColor(Color.texto)
        .padding(.horizontal)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(23)
        .onTapGesture {
            if isEditMode == false {
                noteSheet.toggle()
                selectedHighlight = place
            }
        }
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
