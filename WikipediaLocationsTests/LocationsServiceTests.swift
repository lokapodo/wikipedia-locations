//
//  LocationsServiceTests.swift
//  WikipediaLocationsTests
//
//  Created by Loka on 17.10.2023.
//

import XCTest
@testable import WikipediaLocations

class LocationsServiceTests: XCTestCase {
     
    func testGetLocationsSuccessJsonDecode() throws {
        let jsonData = jsonData(fileName: "locations_valid")
        let mockNetworkService = MockNetworkService(data: jsonData)
        let locationService = LocationsService(networkService: mockNetworkService)
        
        locationService.getLocations { result in
            switch result {
            case .success(let locations):
                XCTAssertEqual(locations, MockData.locations)
            default:
                XCTFail("getLocations should have success result")
            }
        }
    }
    
    func testGetLocationsFailureJsonDecode() throws {
        let jsonData = jsonData(fileName: "locations_invalid")
        let mockNetworkService = MockNetworkService(data: jsonData)
        let locationService = LocationsService(networkService: mockNetworkService)
        
        locationService.getLocations { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            default:
                XCTFail("getLocations should have failure result")
            }
        }
    }
    
    func testGetLocationsFailureRequest() throws {
        let mockNetworkService = MockNetworkService(error: MockError.brokenData)
        let locationService = LocationsService(networkService: mockNetworkService)
        
        locationService.getLocations { result in
            switch result {
            case .failure(let error):
                let resultError = error as? MockError
                XCTAssertEqual(resultError, MockError.brokenData)
            default:
                XCTFail("getLocations should have failure result")
            }
        }
    }
}

extension LocationsServiceTests {
    func jsonData(fileName: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: fileName, ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: filePath))
    }
}

// MARK: - Mocks

private enum MockError: Error {
    case brokenData
}

private struct MockData {
    static let location1 = Location(lat: 53.350140, lon: -6.266155)
    static let location2 = Location(name: "London", lat: 51.509865, lon: -0.118092)
    static let location3 = Location(name: "Barcelona", lat: 41.346176, lon: 2.168365)
    static let locations = [location1, location2, location3]
}

private class MockNetworkService: NetworkServiceProtocol {
    var data: Data?
    var error: Error?
    
    init(data: Data) {
        self.data = data
    }

    init(error: Error) {
        self.error = error
    }
    
    func executeRequest(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = data {
            completion(.success(data))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}

