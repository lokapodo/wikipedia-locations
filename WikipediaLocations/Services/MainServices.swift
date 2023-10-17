//
//  MainServices.swift
//  WikipediaLocations
//
//  Created by Loka on 16.10.2023.
//

import Foundation

protocol MainServicesProtocol {
    var networkService: NetworkServiceProtocol { get }
}

class MainServices: MainServicesProtocol {
    let networkService: NetworkServiceProtocol = NetworkService()
}
