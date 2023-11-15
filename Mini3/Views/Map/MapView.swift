import MapKit
import SwiftUI

public struct MapView: View {
    var tourId: UUID
    
    @EnvironmentObject var placesManager: PlacesManager
    @ObservedObject private var viewModel: MapViewModel = MapViewModel.shared
    @State private var selectedMarker: UUID?
    @State var query = ""
    @State var pinLocation: CLLocationCoordinate2D?
    @State var isShowingAddStopSheet = false
    @State var placeName = ""
    @State var placeTitle = ""
    @State var lastMarkerChange: Date = Date.now
    @State var presentFeedbackView = false
    @State var touchDisabled = false
    
    public func calculateDistance(firstPoint: CLLocationCoordinate2D, secondPoint: CLLocationCoordinate2D) -> Double {
        return sqrt(pow((firstPoint.latitude - secondPoint.latitude), 2) + pow((firstPoint.longitude - secondPoint.longitude), 2)) * 1000000
    }
    
    private func dismissSheet() {
        selectedMarker = nil
    }
    
    private func placeMarker(pinLocation: CLLocationCoordinate2D) {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: pinLocation.latitude, longitude: pinLocation.longitude)) { (places, error) in
            if error == nil {
                if let allPlaces = places {
                    viewModel.temporaryMarker = MarkerModel(name: allPlaces.first?.name ?? "Marker", title: "\(allPlaces.first?.name ?? "") - \(allPlaces.first?.subLocality ?? ""), \(allPlaces.first?.postalCode ?? "")", coordinates: pinLocation)
                }
            }
            selectedMarker = viewModel.temporaryMarker?.id
        }
    }
    
    private func getMinDistance(pinLocation: CLLocationCoordinate2D) -> Double {
        var minDistance: Double = Double.infinity
        for marker in viewModel.markers {
            let distance = calculateDistance(firstPoint: pinLocation, secondPoint: marker.coordinates)
            if (distance < minDistance) {
                minDistance = distance
            }
        }
        if let tempMarker = viewModel.temporaryMarker {
            let distance = calculateDistance(firstPoint: pinLocation, secondPoint: tempMarker.coordinates)
            if (distance < minDistance) {
                minDistance = distance
            }
        }
        return minDistance
    }
    
    func setDismissTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
            self.presentFeedbackView = false
            touchDisabled = false
            timer.invalidate()
        }
        RunLoop.current.add(timer, forMode:RunLoop.Mode.default)
    }
    
    public var body: some View {
        VStack {
            MapReader { reader in
                ZStack {
                    Map(position: $viewModel.position, interactionModes: .all, selection: $selectedMarker) {
                        ForEach(viewModel.markers, id: \.id) { marker in
                            Marker(marker.name, coordinate: marker.coordinates)
                                .tag(marker.id)
                        }
                        if let tempMarker = viewModel.temporaryMarker {
                            Marker(tempMarker.name, coordinate: tempMarker.coordinates)
                                .tag(tempMarker.id)
                        }
                    }
                    .onChange(of: viewModel.selectedSearchLocation, { oldValue, newValue in
                        print("search")
                        guard let result = newValue else { return }
                        viewModel.temporaryMarker = MarkerModel(name: result.name, title: result.title, coordinates: result.coordinate)
                        selectedMarker = viewModel.temporaryMarker?.id
                    })
                    .onChange(of: selectedMarker, { oldValue, newValue in
                        print("changed selected marker")
                        print(lastMarkerChange.distance(to: Date.now))
                        
                        if (lastMarkerChange.distance(to: Date.now) < 0.8) {
                            selectedMarker = oldValue
                            return
                        }
                       
                        if (selectedMarker == nil && oldValue != nil) {
                            print("b")
                            isShowingAddStopSheet = false
                            return
                        }
                        lastMarkerChange = Date.now
                        var markerData = viewModel.markers.first(where: { marker in
                            marker.id == selectedMarker
                        })
                        if (markerData == nil && viewModel.temporaryMarker?.id == selectedMarker) {
                            markerData = viewModel.temporaryMarker
                        }
                        guard let markerData else { return }
                        placeName = markerData.name
                        placeTitle = markerData.title
                        print("sheet presented")
                        isShowingAddStopSheet = true
                        
                    })
                    .onTapGesture { screenCoord in
                        print("touch")
                        if (touchDisabled) {
                            return
                        }
                        pinLocation = reader.convert(screenCoord, from: .local)
                        guard let pinLocation else { return }
                        let minDistance = getMinDistance(pinLocation: pinLocation)
                        print(minDistance)
                        if minDistance > 20 && selectedMarker == nil {
                            placeMarker(pinLocation: pinLocation)
                        }
                    }
                    .sheet(isPresented: $isShowingAddStopSheet, onDismiss: dismissSheet) {
                        AddStopSheetView(tourId: tourId, placeName: $placeName, touchDisabled: $touchDisabled, selectedMarker: $selectedMarker, presentFeedbackView: $presentFeedbackView)
                    }
                    .ignoresSafeArea()
                    
                    
                    
                    if (viewModel.markers.count >= 2 && !isShowingAddStopSheet && !self.presentFeedbackView) {
                        FinishAddingStopsView()
                    }
                    
                    if(self.presentFeedbackView) {
                        StopAddedToTourFeedbackView(setDismissTimer: setDismissTimer)
                    }
                    
                    if (viewModel.searchQuery.count > 0) {
                        SearchLocationView()
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchQuery)
    }
}

//#Preview {
//    SearchableMap(textFieldPlaceHolder: <#T##String#>, search: <#T##Binding<String>#>, onSelectResult: <#T##(SearchResult) -> Void#>)
//}
