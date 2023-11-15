//
//  MarkerModel.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import Foundation
import MapKit

struct MarkerModel: Identifiable, Equatable {
    static func == (lhs: MarkerModel, rhs: MarkerModel) -> Bool {
        return lhs.coordinates.latitude == rhs.coordinates.latitude && lhs.coordinates.longitude == rhs.coordinates.longitude && lhs.name == rhs.name && lhs.title == rhs.title
    }
    
    
    var id = UUID()
    var name: String
    var title: String
    var coordinates: CLLocationCoordinate2D
}

extension MarkerModel {
    static let defaultMarkers = [MarkerModel(name: "test", title: "test", coordinates:  CLLocationCoordinate2D(latitude: -25.4284, longitude: -49.2733))]
}
