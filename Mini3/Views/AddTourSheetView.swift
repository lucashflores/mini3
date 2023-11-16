//
//  AddTourSheetView.swift
//  Mini3
//
//  Created by Lucas Flores on 16/11/23.
//

import SwiftUI

struct AddTourSheetView: View {
    @Binding var tourName: String
    @Binding var newTourSheet: Bool
    @Binding var newTourId: UUID?
    @Binding var isButtonTapped: Bool
    var addTour: () -> UUID
    
    var body: some View {
        VStack() {
            Text("Give your tour a name")
                .font(.appBody)
            
            TextField("My Tour", text: $tourName)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(20)
                .overlay(VStack{Divider().offset(x: 0, y: 15)}.padding(.horizontal, 64).padding(.top).foregroundStyle(.tertiary))
            
            
            VStack {
                HStack(spacing: 2) {
                    CategoryNameTour(category: CategoryModel.categories[0].name, icon: CategoryModel.categories[0].icon)
                    CategoryNameTour(category: CategoryModel.categories[1].name, icon: CategoryModel.categories[1].icon)
                    CategoryNameTour(category: CategoryModel.categories[2].name, icon: CategoryModel.categories[2].icon)
                }
                HStack(spacing: 2) {
                    CategoryNameTour(category: CategoryModel.categories[3].name, icon: CategoryModel.categories[3].icon)
                    CategoryNameTour(category: CategoryModel.categories[4].name, icon: CategoryModel.categories[4].icon)
                    CategoryNameTour(category: CategoryModel.categories[5].name, icon: CategoryModel.categories[5].icon)
                }
            }
            .padding(.bottom, 32)
//            LazyHGrid(rows: [GridItem(.fixed(90), spacing: 0), GridItem(.fixed(90), spacing: 0)], spacing: 10) {
//                ForEach(CategoryModel.categories) { category in
//                    
//                        .padding(-5)
//                }
//            }
//            .padding(.horizontal)
            
            
            Button("Create a tour") {
                newTourSheet = false
                newTourId = addTour()
                isButtonTapped = true
            }
            .font(.appButton)
            .padding()
            .background(Color("Alaranjado"))
            .foregroundColor(.white)
            .cornerRadius(30)
        }
        .padding()
        .presentationDetents([.fraction(0.8), .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    AddTourSheetView(tourName: .constant("My Tour"), newTourSheet: .constant(true), newTourId: .constant(UUID()), isButtonTapped: .constant(false)) {
        return UUID()
    }
}
