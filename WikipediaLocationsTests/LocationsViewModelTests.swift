//
//  LocationsViewModelTests.swift
//  WikipediaLocationsTests
//
//  Created by Loka on 15.10.2023.
//

import XCTest
@testable import WikipediaLocations

class LocationsViewModelTests: XCTestCase {
     
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testLocationsFetchSuccess() throws {
        let mockNetworkService = MockNetworkService(data: MockData.locations)
        let viewModel = LocationsViewModel(networkService: mockNetworkService)
        viewModel.fetchLocations()
        
        XCTAssertEqual(viewModel.locations, MockData.locations)
    }
    
    func testLocationsFetchFailure() throws {
        let mockNetworkService = MockNetworkService(error: MockError.wrongLatLonFormat)
        let viewModel = LocationsViewModel(networkService: mockNetworkService)
        viewModel.fetchLocations()
        
        let resultError = viewModel.error as? MockError
        XCTAssertEqual(resultError, MockError.wrongLatLonFormat)
    }

}

// MARK: - Mocks

                                                    
struct MockData {
    static let location1 = Location(name: "Dublin", lat: 53.350140, lon: -6.266155)
    static let location2 = Location(name: "London", lat: 51.509865, lon: -0.118092)
    static let location3 = Location(name: "Barcelona", lat: 41.346176, lon: 2.168365)
    
    static let locations = [location1, location2, location3]
}
      
enum MockError: Error {
    case wrongLatLonFormat
}

class MockNetworkService: LocationsNetworking {
    
    var data: [Location]?
    var error: Error?
    
    init(data: [Location]) {
        self.data = data
    }

    init(error: Error) {
        self.error = error
    }
    
    func getLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
