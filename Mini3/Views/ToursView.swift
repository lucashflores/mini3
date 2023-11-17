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
    @State private var tourName: String = "My Tour"
    @State private var selectedCategory: String = "No category"
    
    @State private var newTourSheet: Bool = false
    
    // Navegação para a página que acabou de ser criada:
    @State private var isButtonTapped = false
    @State private var newTourId: UUID?
    
    @State var draggedItem: TourModel = TourModel(name: "Aleatorio", category: "No Category")
    
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: PointsView(tourId: newTourId ?? UUID()), isActive: $isButtonTapped) {
                EmptyView()
            }
            .hidden()
            
            VStack(spacing: -8){
                Text("See")
                    .font(Font.appBoldTitle)
                    .frame(width: 350, alignment: .leading)
                Text("your tours")
                    .font(Font.appTitle)
                    .frame(width: 350, alignment: .leading)
            }
            .padding()
            .foregroundColor(Color.black)
            
            ScrollView(){
                
                
                
                LazyVStack(spacing:12){
                    //           .hidden()
                    
//                    Button("Adicionar Tour", systemImage: "arrow.up", action: { newTourSheet.toggle() })
                    
                    ScrollView{
                        LazyVStack(spacing:16){
//                            NavigationLink(destination: EmptyView()) {
//                                TourItem(tourModel: TourModel(
//                                    name: "Tour"
//                                    
//                                ))
//                            }
                            
                            ForEach(tourModels, id: \.id) { tour in
                                NavigationLink(destination: PointsView(tourId: tour.id)) {
                                    TourItem(tourModel: tour)
                                }
//                                .onLongPressGesture {
//                                    tourManager.deleteTour(tourId: tour.id)
//                                    update()
//                                }
                            }
                        }
                        
                        Button(action: {
                            newTourSheet.toggle()
                        }, label: {
                            CardTourDefault()
                        })
                        .opacity(0.7)
                        //           Button("Adicionar Tour", systemImage: "arrow.up", action: { newTourSheet.toggle() })
                        
                    }
                    .onAppear {
                        
                        // Fetch the TourModels when the view appears
                        tourModels = tourManager.fetchAllTourModels()
                    }
                    Spacer()
                    
                }
//                .navigationTitle("All Tours")
//                .background(.red)
                .sheet(isPresented: $newTourSheet) {
                    AddTourSheetView(tourName: $tourName, newTourSheet: $newTourSheet, newTourId: $newTourId, isButtonTapped: $isButtonTapped, categorySelected: $selectedCategory, addTour: addTour)
                    //           .interactiveDismissDisabled()
                }
                
            }
        }
    }
    
    func TourItem(tourModel: TourModel) -> some View {
        ZStack(alignment: .topLeading) {
            CardTour()
            VStack(alignment: .leading)
            {
                Text(tourModel.name)
                    .font(.appCardsTitle)
                    .foregroundColor(.white)
                
                HStack{
                    
                    ZStack(alignment: .center){
                        StopPoints()
                        Text(String(tourManager.getPlacesQuantity(tourId: tourModel.id)))
                            .frame(width: 25, height: 24, alignment: .trailing)
                            .foregroundStyle(.white)
                    }
                    
                    Categories(category: tourModel.category)
                }
                
                
            }
            .padding()
        }

    }
    
    func addTour() -> UUID {
//        newTourSheet = false
        let newTour = TourModel(name: tourName, category: selectedCategory)
        tourManager.createTour(tour: newTour)
        update()
        return newTour.id
        
    }
    
    func deleteTour(id: UUID){
        tourManager.deleteTour(tourId: id)
        update()
    }   
    
    func update() {
        
        tourModels = tourManager.fetchAllTourModels()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        tourModels.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ToursView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(TourManager(controller: PersistenceController.shared))
        .environmentObject(PlacesManager(controller: PersistenceController.shared))
}
