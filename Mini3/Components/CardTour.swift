//
//  CardTour.swift
//  Mini3
//
//  Created by Gabriela Nunes on 14/11/23.
//

import SwiftUI

//var tourName: String = ""
//var numStops: Int = String // Nao sei dar o valor, desculpa sou burra
//var tourCategory: String = "Gastronomic" // não sei colocar o Icon gente

struct CardTour: View {
    
    var body: some View {
            
            ZStack(alignment: .topLeading){
                Rectangle()
                    .foregroundColor(.itiAzul)
                    .frame(width: 380, height: 120)
                    .cornerRadius(23)
                
                Image("MaskPin")
                
                VStack(alignment: .leading){
//                    Text("Ola")
//                        .font(.appCardsTitle)
//                        .foregroundColor(.white)
                    
//                    HStack{
//                        ZStack{
//                            Rectangle()
//                                .foregroundColor(Color(uiColor: .quaternaryLabel))
//                                .frame(width: 50, height: 24)
//                                .cornerRadius(20)
//                            HStack{
//                                Image("PinStops")
//                                Text("0")
//                                    .font(.callout)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                        ZStack{
//                            Rectangle()
//                                .foregroundColor(Color(uiColor: .quaternaryLabel))
//                                .frame(width: 140, height: 24)
//                                .cornerRadius(20)
//                            HStack(){
//                                Image(systemName: "staroflife")
//                                    .font(.callout)
//                                    .foregroundColor(.white)
//                                Text("Categoria")
//                                    .font(.callout)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                    }
                    
                }
                .padding(.horizontal, 15)
                
            }
        }
        
    }

    func TourItem(tourModel: TourModel) -> some View {
        
        VStack(){
            Text(tourModel.name)
//            Text(String(tourManager.getPlacesQuantity(tourId: tourModel.id)))
            
        }
    }

#Preview {
    CardTour()
}
