//
//  MainBuilderTests.swift
//  WikipediaLocationsTests
//
//  Created by Loka on 17.10.2023.
//

import XCTest
@testable import WikipediaLocations

final class MainBuilderTests: XCTestCase {

    func testViewModelSet() throws {
        let mockNetworkService = MockNetworkService()
        let mockMainServices = MockMainServices(networkService: mockNetworkService)
        let mainBuilder = MainBuilder(mainServices: mockMainServices)
        let viewController = LocationsViewController()
        XCTAssertNil(viewController.viewModel)

        mainBuilder.configureLocationsViewController(viewController)
        XCTAssertNotNil(viewController.viewModel)
    }

}

// MARK: - Mocks

class MockNetworkService: NetworkServiceProtocol {
    func executeRequest(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {}
}

class MockMainServices: MainServicesProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
