//
//  MainServices.swift
//  WikipediaLocations
//
//  Created by Loka on 16.10.2023.
//

import Foundation

protocol MainServicesProtocol {
    var networkService: NetworkService { get }
}

class MainServices: MainServicesProtocol {
    
    let networkService = NetworkService()
    
}
