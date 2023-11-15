//
//  AddStopSheetView.swift
//  Mini3
//
//  Created by Lucas Flores on 14/11/23.
//

import SwiftUI

struct AddStopSheetView: View {
    @Binding var placeName: String
    @Binding var touchDisabled: Bool
    @Binding var temporaryMarker: MarkerModel?
    @Binding var markers: [MarkerModel]
    @Binding var selectedMarker: UUID?
    @Binding var presentFeedbackView: Bool
    var placeTitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Place name", text: $placeName)
                .font(.system(size: 18, weight: .bold))
                .padding(.top, 16)
            Text(placeTitle)
                .font(.caption2)
                .padding(.bottom, 32)
            Button {
                touchDisabled = true
                guard var markerData = temporaryMarker else { return }
                markerData.name = placeName
                markers.append(markerData)
                selectedMarker = nil
                presentFeedbackView = true
            
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.white)
                    Text("Add stop")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
                
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 35))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color("AddStopSheet"))
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .presentationDetents([.height(200)])
        .presentationDragIndicator(.visible)
    }
}

//#Preview {
//    AddStopSheetView()
//}
