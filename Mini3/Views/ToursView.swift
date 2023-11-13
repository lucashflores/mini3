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
    
    @State private var newTourSheet: Bool = false
    
    // Navegação para a página que acabou de ser criada:
    @State private var isButtonTapped = false
    @State private var newTourId: UUID?
    
    var body: some View {
       NavigationStack {
           
           NavigationLink(destination: PointsView(tourId: newTourId ?? UUID()), isActive: $isButtonTapped) {
               EmptyView()
           }
           .hidden()
           
           Button("Adicionar Tour", systemImage: "arrow.up", action: { newTourSheet.toggle() })
           
           ScrollView{
               VStack{
                   
                   ForEach(tourModels, id: \.id) { tour in
                       NavigationLink(destination: PointsView(tourId: tour.id)) {
                           TourItem(tourModel: tour)
                       }
                       
                   }
                   .onMove(perform: move)
               }
           }
           .onAppear {
               
               // Fetch the TourModels when the view appears
               tourModels = tourManager.fetchAllTourModels()
           }
           .background(.yellow)
           
           Spacer()
           
       }
       .navigationTitle("All Tours")
       .background(.red)
       .sheet(isPresented: $newTourSheet){
           VStack{
               
               
               TextField("Enter tour name: ", text: $tourName)

               
               Button("Adicionar Tour") {
                   newTourSheet = false
                   newTourId = addTour()
                   isButtonTapped = true
                   
               }
           }
           .presentationDetents([.fraction(0.9)])
           .interactiveDismissDisabled()
       }
       
    }
    
    func TourItem(tourModel: TourModel) -> some View {
        
        VStack(){
            Text(tourModel.name)
                .foregroundColor(.black)
            Text(String(tourManager.getPlacesQuantity(tourId: tourModel.id)))
                .foregroundStyle(.cyan)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
        .padding(.vertical, 22)
        .background(.gray)
        
    }
    
    func addTour() -> UUID {
//        newTourSheet = false
        let newTour = TourModel(name: tourName)
        tourManager.createTour(tour: newTour)
        update()
        return newTour.id
        
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
    
    func move(from source: IndexSet, to destination: Int) {
        tourModels.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
    ToursView()
}
