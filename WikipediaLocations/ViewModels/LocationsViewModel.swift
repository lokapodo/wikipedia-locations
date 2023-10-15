//
//  LocationsViewModel.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import Foundation

class LocationsViewModel {
    
    // MARK: - Properties
    
//    @Published var isLoading: Bool = false
    @Published var locations: [Location] = []
    
    private let locationsNetworkService: LocationsNetworkService
    
    // MARK: - Initialization
    
    init(networkService: LocationsNetworkService) {
        self.locationsNetworkService = networkService
    }
    
    // MARK: - Methods
    
    func fetchLocations() {
//        isLoading = true
        
        locationsNetworkService.getLocations { [weak self] result in
            guard let strongSelf  = self else { return }
            
//            strongSelf.isLoading = false
            
            switch result {
            case .success(let locations):
                strongSelf.locations = locations
            case .failure(let error):
                print("Error occurred while getting locations: ", error)
            }
        }
    }
    
}
