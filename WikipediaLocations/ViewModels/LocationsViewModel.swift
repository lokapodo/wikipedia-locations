//
//  LocationsViewModel.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import Foundation
import UIKit

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
    
    func openWikipedia(location: Location) {
        let lat = String(format: "%.7f", location.lat)
        let lon = String(format: "%.7f", location.lon)
        guard let url = URL(string: "wikipedia://places?lat=\(lat)&lon=\(lon)") else { return }
        UIApplication.shared.open(url)
    }
    
}
