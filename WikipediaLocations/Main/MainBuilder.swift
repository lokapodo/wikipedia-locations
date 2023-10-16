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
        let locationsNetworkService = LocationsNetworkService(networkService: networkService)
        let viewModel = LocationsViewModel(networkService: locationsNetworkService)
        viewController.viewModel = viewModel
    }
}

