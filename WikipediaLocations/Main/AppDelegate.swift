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
        
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        let locationsViewController = mainBuilder.buildLocationsViewController()
        let navigationController = UINavigationController(rootViewController: locationsViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

