//
//  MainBuilder.swift
//  WikipediaLocations
//
//  Created by Loka on 16.10.2023.
//

import Foundation

protocol MainBuilderProtocol {
    func configureLocationsViewController(_ viewController: LocationsViewController)
}

class MainBuilder: MainBuilderProtocol {
    
    private let mainServices: MainServicesProtocol
    
    init(mainServices: MainServicesProtocol) {
        self.mainServices = mainServices
    }
    
    func configureLocationsViewController(_ viewController: LocationsViewController) {
        let networkService = mainServices.networkService
        let locationsService = LocationsService(networkService: networkService)
        let viewModel = LocationsViewModel(locationsService: locationsService)
        viewController.viewModel = viewModel
    }
}

