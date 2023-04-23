//
//  LocationListViewModel.swift
//  rickandmorty
//
//  Created by Mete Varol on 17.04.2023.
//

import Foundation
import SwiftUI
import Combine

class LocationListViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    
    func fetchLocations() {
        networkManager.fetchLocations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching locations: \(error.localizedDescription)")
                }
            }, receiveValue: { locations in
                self.locations = locations
            })
            .store(in: &cancellables)
        
    }
}
