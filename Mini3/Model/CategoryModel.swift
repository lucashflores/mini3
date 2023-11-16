//
//  Category.swift
//  Mini3
//
//  Created by Lucas Flores on 16/11/23.
//

import Foundation
struct CategoryModel: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
}

extension CategoryModel {
    static public let categories: [CategoryModel] = [CategoryModel(name: "Adventure", icon: "figure.hiking"), CategoryModel(name: "Cultural", icon: "theatermasks"), CategoryModel(name: "Entertainment", icon: "music.mic.circle.fill"), CategoryModel(name: "Gastronomic", icon: "fork.knife"), CategoryModel(name: "Religious", icon: "book.closed"), CategoryModel(name: "No category", icon: "figure.walk")]
}
