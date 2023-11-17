//
//  CardHighlightExemple.swift
//  Mini3
//
//  Created by Gabriela Nunes on 16/11/23.
//

import SwiftUI

struct CardHighlightExemple: View {
    var body: some View {
        VStack{
            ZStack(alignment: .topLeading){
                Rectangle()
                    .foregroundColor(.itiAlaranjado)
                    .frame(width: 380, height: 120)
                    .cornerRadius(23)
                
                
                VStack(alignment: .leading){
                    HStack{
                        Image("PinStops")
                        Text("Add new highlight")
                            .font(.appCardsTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                            .padding(.trailing, 85)
                    
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    Text("Your notes go here")
                        .font(.appBody)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                
            }
        }
    }
}

#Preview {
    CardHighlightExemple()
}
