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
    
    var body: some View {
        
        Button {
            selected.toggle()
        } label: {
                HStack(){
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(selected ? .white : .itiAzulEscuro)
                    Text(category)
                        .font(.categoryName)
                        .foregroundColor(selected ? .white : .itiAzulEscuro)
                    }
                .padding(.vertical, 3)
                .padding(.horizontal, 9)
                .background(selected ? .itiAzulEscuro : Color(uiColor: .systemFill))
                .cornerRadius(20)
                
            }
        }
    }


#Preview {
    CategoryNameTour(category: "Culture", icon: "mic.circle.fill")
}
