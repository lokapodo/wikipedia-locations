//
//  LocationsNetworkService.swift
//  WikipediaLocations
//
//  Created by Loka on 15.10.2023.
//

import Foundation

protocol LocationsServiceProtocol {
    func getLocations(completion: @escaping (Result<[Location], Error>) -> Void)
}

class LocationsService: LocationsServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    
    func getLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        
        let urlString = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
        let url = URL(string: urlString)!

        networkService.executeRequest(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let wrapper = try JSONDecoder().decode(LocationsWrapper.self, from: data)
                    completion(.success(wrapper.locations))
                } catch (let error) {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
