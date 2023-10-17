//
//  LocationsViewModelTests.swift
//  WikipediaLocationsTests
//
//  Created by Loka on 15.10.2023.
//

import XCTest
import Combine
@testable import WikipediaLocations

class LocationsViewModelTests: XCTestCase {

    func testLocationsFetchSuccess() throws {
        let mockService = MockLocationsService(data: MockData.locations)
        let viewModel = LocationsViewModel(locationsService: mockService)
        
        var cancellables: Set<AnyCancellable> = []
        let expectation = XCTestExpectation()
        
        viewModel.$locations
            .dropFirst()
            .sink { locations in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        viewModel.fetchLocations()
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.locations, MockData.locations)

    }
    
    func testLocationsFetchFailure() throws {
        let mockService = MockLocationsService(error: MockError.brokenData)
        let viewModel = LocationsViewModel(locationsService: mockService)

        var cancellables: Set<AnyCancellable> = []
        let expectation = XCTestExpectation()
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                expectation.fulfill()
            }.store(in: &cancellables)
        
        viewModel.fetchLocations()
        
        wait(for: [expectation], timeout: 1.0)
        
        let resultError = viewModel.error as? MockError
        XCTAssertEqual(resultError, MockError.brokenData)
    }

}

// MARK: - 

extension Location: Equatable {
    public static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.lat == rhs.lat && lhs.lon == rhs.lon && lhs.name == rhs.name
    }
}

// MARK: - Mocks

private struct MockData {
    static let location1 = Location(name: "Dublin", lat: 53.350140, lon: -6.266155)
    static let location2 = Location(name: "London", lat: 51.509865, lon: -0.118092)
    static let location3 = Location(name: "Barcelona", lat: 41.346176, lon: 2.168365)
    
    static let locations = [location1, location2, location3]
}
      
private enum MockError: Error {
    case brokenData
}

private class MockLocationsService: LocationsServiceProtocol {
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
