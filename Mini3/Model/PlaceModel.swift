//
//  PlaceModel.swift
//  Mini3
//
//  Created by Andrea Oquendo on 09/11/23.
//

import Foundation

struct PlaceModel {
    var id = UUID()
    var name: String
    var orderNumber: Int
//    var picture: String? // picture name - optional
    var notes: String? // description - optional
    var tourId: UUID?
    var title: String
    var latitude: Double
    var longitude: Double
    // provavelmente botar coordenadas
}

