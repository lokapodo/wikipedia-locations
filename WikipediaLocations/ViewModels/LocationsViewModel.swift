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
    
    @Published private(set) var locations: [Location] = []
    @Published private(set) var error: Error? = nil
    @Published private(set) var isLoading: Bool = false
    
    private let locationsService: LocationsServiceProtocol
    
    // MARK: - Initialization
    
    init(locationsService: LocationsServiceProtocol) {
        self.locationsService = locationsService
    }
    
    // MARK: - Public Methods
    
    func fetchLocations() {
        isLoading = true
        
        locationsService.getLocations { [weak self] result in
            guard let self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let locations):
                self.locations = locations
            case .failure(let error):
                print("Error occurred while getting locations: ", error)
                self.error = error
            }
        }
    }
    
    func openWikipedia(location: Location) {
        let lat = String(format: "%.6f", location.lat)
        let lon = String(format: "%.6f", location.lon)
        guard let url = URL(string: "wikipedia://places?lat=\(lat)&lon=\(lon)") else { return }
        UIApplication.shared.open(url)
    }
    
}
