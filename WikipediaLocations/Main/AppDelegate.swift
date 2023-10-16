//
//  AppDelegate.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let mainServices = MainServices()
    private lazy var mainBuilder: MainBuilderProtocol = MainBuilder(mainServices: mainServices)

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupInitialViewController()
        
        return true
    }
    
    func setupInitialViewController() {
        guard let locationsViewController = self.locationsViewController else {
            fatalError("Could not setup initial view controller from the storyboard")
        }
        mainBuilder.configureLocationsViewController(locationsViewController)
    }

    private var locationsViewController: LocationsViewController? {
        let navigationController = window?.rootViewController as? UINavigationController
        let viewController = navigationController?.viewControllers.first as? LocationsViewController
        return viewController
    }

}

