//
//  SceneDelegate.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession, 
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let navigationController = window?.rootViewController as? UINavigationController,
              let locationsViewController = navigationController.viewControllers.first as? LocationsTableViewController
        else { return }
        
        let networkService = NetworkService()
        let locationsNetworkService = LocationsNetworkService(networkService: networkService)
        let viewModel = LocationsViewModel(networkService: locationsNetworkService)
        locationsViewController.viewModel = viewModel
    }

}

