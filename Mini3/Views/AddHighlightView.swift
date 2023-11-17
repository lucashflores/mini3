//
//  AddHighlightView.swift
//  Mini3
//
//  Created by Gabriela Nunes on 16/11/23.
//

import SwiftUI

struct AddHighlightView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            VStack(alignment: .leading, spacing: -8){
                Text("Your tour")
                    .font(.appTitle)
                Text("highlights")
                    .font(.appBoldTitle)
            }
            HStack{
                Text("Tour name")
                    .font(.appCardsTitle)
                    .foregroundColor(.subTitleColor)
                Image(systemName: "pencil.line")
                    .foregroundColor(.subTitleColor)
            }
            
            Categories(category: CategoryModel.categories[0].name)
                .padding(.vertical, -10)
            
            Text("Add your tour highlights and start taking notes to get the best out of Itinote!")
                .font(.appBody)
                .multilineTextAlignment(.center)
                .frame(width:340)
                .padding(.top, 80)
        }
        
        Button(action: {
            
        }, label: {
            CardHighlightExemple()
        })
            .padding(44)
        Spacer()
    }
    
}

#Preview {
    AddHighlightView()
}
