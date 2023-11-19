import MapKit

class MapKitDataAccess: DataAccess {
    func fetch(request: MapSearchRequest) async throws -> [MKMapItem] {
        let mapKitRequest = MKLocalSearch.Request()
        mapKitRequest.naturalLanguageQuery = request.query
        mapKitRequest.resultTypes = [.pointOfInterest, .address]
        let search = MKLocalSearch(request: mapKitRequest)
        
        let response = try await search.start()
        
        return response.mapItems
    }
}
