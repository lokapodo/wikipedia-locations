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
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func getLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        
        let urlString = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"

        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        networkService.executeRequest(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let dict = try JSONDecoder().decode([String: [Location]].self, from: data)
                    let locations: [Location] = dict["locations"] ?? [] // FIXME: handle [] case?
                    completion(.success(locations))
                } catch (let error) {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
