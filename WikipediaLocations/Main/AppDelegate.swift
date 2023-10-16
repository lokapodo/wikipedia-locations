//
//  AppDelegate.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let mainServices = MainServices()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let navigationController = window?.rootViewController as? UINavigationController,
              let locationsViewController = navigationController.viewControllers.first as? LocationsTableViewController
        else {
            print("Error occurred, when setting up initial view controller")
            return false
        }
        
        let networkService = mainServices.networkService
        let locationsNetworkService = LocationsNetworkService(networkService: networkService)
        let viewModel = LocationsViewModel(networkService: locationsNetworkService)
        locationsViewController.viewModel = viewModel
        
        return true
    }


}

