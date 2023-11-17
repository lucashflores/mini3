//
//  AddStopSheetView.swift
//  Mini3
//
//  Created by Lucas Flores on 14/11/23.
//

import SwiftUI

struct AddStopSheetView: View {
    @EnvironmentObject var placesManager: PlacesManager
    @ObservedObject var mapViewModel = MapViewModel.shared
    var tourId: UUID
    @Binding var placeName: String
    @Binding var touchDisabled: Bool
    @Binding var selectedMarker: UUID?
    @Binding var presentFeedbackView: Bool
    
    @FocusState private var placeNameInFocus: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Place name", text: $placeName)
                .focused($placeNameInFocus)
                .font(.system(size: 18, weight: .bold))
                .padding(.top, 16)
            Text(mapViewModel.temporaryMarker?.title ?? "")
                .font(.caption2)
                .padding(.bottom, 32)
            Button {
                touchDisabled = true
                guard var markerData = mapViewModel.temporaryMarker else { return }
                markerData.name = placeName
                placesManager.createPoint(place: PlaceModel(name: markerData.name, orderNumber: 1, tourId: tourId, title: markerData.title, latitude: markerData.coordinates.latitude, longitude: markerData.coordinates.longitude), placeCount: mapViewModel.markers.count)
                mapViewModel.markers.append(markerData)
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
                .background(.azulEscuro)
                .clipShape(RoundedRectangle(cornerRadius: 35))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            placeNameInFocus = true
        }
        .padding()
        .background(Color.cinzaSheet)
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
        .presentationDetents([.height(200)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    ZStack {
        Color.white
            .ignoresSafeArea()
        
        AddStopSheetView(tourId: UUID(), placeName: .constant("teste"), touchDisabled: .constant(true), selectedMarker: .constant(UUID()), presentFeedbackView: .constant(true))
    }
}
