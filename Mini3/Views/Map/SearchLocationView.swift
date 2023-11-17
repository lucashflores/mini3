//
//  SearchLocationView.swift
//  Mini3
//
//  Created by Lucas Flores on 15/11/23.
//

import SwiftUI

struct SearchLocationView: View {
    @ObservedObject var viewModel: MapViewModel = MapViewModel.shared
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.searchResults) { result in
                    Button(action: { viewModel.didSelectResult(result) }) {
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundStyle(.white, .black)
                                .font(.system(size: 48))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(result.name)
                                        .font(.headline)
                                Text(result.title)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .foregroundStyle(.primary)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .background(.white)
    }
}

#Preview {
    SearchLocationView()
}
