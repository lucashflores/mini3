//
//  StopAddedToTourVIEW.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import SwiftUI

struct StopAddedToTourView: View {
    var setDismissTimer: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Stop added to tour")
                .padding(.vertical)
                .padding(.horizontal, 100)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 2, x: 2, y: 2)
        }
        .onAppear(perform: setDismissTimer)
    }
}

#Preview {
    ZStack {
        Color.gray
            .ignoresSafeArea()
        
        StopAddedToTourView(setDismissTimer: {
            print("timer")
        })
    }
}
