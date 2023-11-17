//
//  Category.swift
//  Mini3
//
//  Created by Gabriela Nunes on 15/11/23.
//

import SwiftUI

struct CategoryNameTour: View {
    var category: String
    var icon: String
    @State var selected = false
    @Binding var categorySelected: String
    
    var body: some View {
        
        Button {
            if categorySelected == category {
                categorySelected = ""
            } else {
                categorySelected = category
            }
            
        } label: {
                HStack(){
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(categorySelected == category ? .white : .itiAzulEscuro)
                    Text(category)
                        .font(.categoryName)
                        .foregroundColor(categorySelected == category ? .white : .itiAzulEscuro)
                    }
                .padding(.vertical, 3)
                .padding(.horizontal, 9)
                .background(categorySelected == category ? .itiAzulEscuro : Color(uiColor: .systemFill))
                .cornerRadius(20)
                
            }
        }
    }


//#Preview {
//    CategoryNameTour(category: "Culture", icon: "mic.circle.fill")
//}
