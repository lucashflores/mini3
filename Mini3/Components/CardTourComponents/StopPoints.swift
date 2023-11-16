//
//  StopPoints.swift
//  Mini3
//
//  Created by Gabriela Nunes on 15/11/23.
//

import SwiftUI

struct StopPoints: View {
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(Color(uiColor: .quaternaryLabel))
                .frame(width: 45, height: 24)
                .cornerRadius(20)
            
            HStack{
                Image("PinStops")
                Text("")
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
    StopPoints()
}
