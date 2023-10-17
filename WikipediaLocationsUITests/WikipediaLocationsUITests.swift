//
//  WikipediaLocationsUITests.swift
//  WikipediaLocationsUITests
//
//  Created by Loka on 15.10.2023.
//

import XCTest

final class WikipediaLocationsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    func testErrorAlertDisplay() {
        let app = XCUIApplication()
        app.launch()
        
        let textFieldLat = app.textFields["text_field_lat"]
        let textFieldLon = app.textFields["text_field_lon"]
        textFieldLat.tap()
        textFieldLat.typeText("abc")
        textFieldLon.tap()
        textFieldLon.typeText("30.24212")
        
        let openWikipediaButton = app.buttons["open_wikipedia_button"]
        openWikipediaButton.tap()
        
        let errorAlert = app.alerts["error_alert"]
        XCTAssertTrue(errorAlert.exists, "Error alert should be displayed")
        
        errorAlert.buttons["Ok"].tap()
    }
    
    func testValidLatLonEnter() {
        let app = XCUIApplication()
        app.launch()
        
        let textFieldLat = app.textFields["text_field_lat"]
        let textFieldLon = app.textFields["text_field_lon"]
        textFieldLat.tap()
        textFieldLat.typeText("38.736946")
        textFieldLon.tap()
        textFieldLon.typeText("-9.142685")
        
        let openWikipediaButton = app.buttons["open_wikipedia_button"]
        openWikipediaButton.tap()
        
        // Chech if there is no alert
        let noAlertExpectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "count == 0"),
            object: app.alerts
        )
        let result = XCTWaiter.wait(for: [noAlertExpectation], timeout: 3.0)

        if result == .completed {
            // No alert appeared within the expected time, so it's as expected
        } else {
            XCTFail("An alert was shown after tapping the button")
        }
        
        // Chech if app goes to background (redirects to wikipedia)
        let expectation = expectation(for: NSPredicate(format: "self.state == %d", XCUIApplication.State.runningBackground.rawValue), evaluatedWith: app, handler: nil)

        let timeout: TimeInterval = 5.0
        waitForExpectations(timeout: timeout, handler: nil)

    }
}
