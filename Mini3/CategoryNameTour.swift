//
//  Category.swift
//  Mini3
//
//  Created by Gabriela Nunes on 15/11/23.
//

import SwiftUI

struct CategoryNameTour: View {
    @State var selected = false
    
    var body: some View {
        
        Button {
            selected.toggle()
        } label: {
                HStack(){
                    Image(systemName: "mic.circle.fill")
                        .font(.callout)
                        .foregroundColor(selected ? .white : .itiAzulEscuro)
                    Text("Culture")
                        .font(.callout)
                        .foregroundColor(selected ? .white : .itiAzulEscuro)
                    }
                .padding(.vertical,3)
                .padding(.horizontal, 9)
                .background(selected ? .itiAzulEscuro : Color(uiColor: .systemFill))
                .cornerRadius(20)
                
            }
        }
    }


#Preview {
    CategoryNameTour()
}
