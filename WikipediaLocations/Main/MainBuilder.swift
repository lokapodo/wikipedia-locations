//
//  MainBuilder.swift
//  WikipediaLocations
//
//  Created by Loka on 16.10.2023.
//

import Foundation
import UIKit

protocol MainBuilderProtocol {
    func buildLocationsViewController() -> LocationsViewController
}

class MainBuilder: MainBuilderProtocol {

    private let mainServices: MainServicesProtocol
    
    init(mainServices: MainServicesProtocol) {
        self.mainServices = mainServices
    }
    
    // MARK: - Public Methods
    
    func buildLocationsViewController() -> LocationsViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LocationsViewControllerStoryboardID") as? LocationsViewController
        else {
            fatalError("Could not setup LocationsViewController from the storyboard")
        }
        
        let networkService = mainServices.networkService
        let locationsService = LocationsService(networkService: networkService)
        let viewModel = LocationsViewModel(locationsService: locationsService)
        viewController.viewModel = viewModel
        
        return viewController
    }
}

