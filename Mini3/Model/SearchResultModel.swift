//
//  SearchResultModel.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import Foundation
import MapKit

public struct SearchResultModel: Identifiable, Equatable {
    public static func == (lhs: SearchResultModel, rhs: SearchResultModel) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.name == rhs.name && lhs.title == rhs.title
    }
    
    public let name: String
    public let title: String
    public let id: UUID
    public let coordinate: CLLocationCoordinate2D
    
    public init(name: String, title: String, id: UUID, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.title = title
        self.id = id
        self.coordinate = coordinate
    }
}
