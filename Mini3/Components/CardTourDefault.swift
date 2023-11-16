//
//  SwiftUIView.swift
//  Mini3
//
//  Created by Gabriela Nunes on 14/11/23.
//

import SwiftUI

struct CardTourDefault: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            Rectangle()
                .foregroundColor(Color(uiColor: .systemFill))
                .frame(width: 380, height: 120)
                .cornerRadius(23)
        
            Image("MaskPin")
            
            VStack(alignment: .leading){
                HStack(spacing: 200){
                    Text("Add a tour")
                        .font(.appCardsTitle)
                        .foregroundColor(Color(.darkGray))
                    
                    Image(systemName: "plus")
                        .foregroundColor(Color(.darkGray))
                        .font(.largeTitle)
                }
                
                HStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(uiColor: .tertiaryLabel))
                            .frame(width: 50, height: 24)
                            .cornerRadius(20)
                        HStack{
                            Image("PinStopsGray")
                            Text("0")
                                .font(.callout)
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(uiColor: .tertiaryLabel))
                            .frame(width: 110, height: 24)
                            .cornerRadius(20)
                        HStack(){
                            Image(systemName: "staroflife")
                                .font(.callout)
                                .foregroundColor(Color(.darkGray))
                            Text("Category")
                                .font(.callout)
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                }
                
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
        }
    }
}

#Preview {
    CardTourDefault()
}
