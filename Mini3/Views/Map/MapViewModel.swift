//
//  SearchableMapViewmodel.swift
//  Mini3
//
//  Created by Lucas Flores on 08/11/23.
//

import Foundation
import SwiftUI
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var selectedPresentationDetent = PresentationDetent.height(150)
    @Published var selectedSearchLocation: SearchResultModel? = nil
    @Published var searchResults = [SearchResultModel]()
    @Published var searchQuery: String = ""
    let searchPlaceHolder: String = "Search a location"
    
    private let searchService: SearchLocationService = SearchLocationServiceFactory.make()
    private var cancellables = Set<AnyCancellable>()
    
    static public let shared = MapViewModel()
    
    private init() {
        $searchQuery
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { query in
                self.search(with: query)
            }
            .store(in: &cancellables)
    }
    
    private func search(with query: String) {
        Task {
            let results = try await searchService.search(with: query)
            
            RunLoop.main.perform {
                self.searchResults = results
            }
        }
    }
    
    func didSelectResult(_ result: SearchResultModel) {
        searchQuery = ""
        selectedSearchLocation = result
        position = .item(.init(placemark: .init(coordinate: result.coordinate)))
    }
}
