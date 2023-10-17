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

    func testErrorAlertDisplayWrongLat() {
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
    
    func testErrorAlertDisplayWrongLon() {
        let app = XCUIApplication()
        app.launch()
        
        let textFieldLat = app.textFields["text_field_lat"]
        let textFieldLon = app.textFields["text_field_lon"]
        textFieldLat.tap()
        textFieldLat.typeText("50.293475")
        textFieldLon.tap()
        textFieldLon.typeText("2°10'26.5\"E")
        
        let openWikipediaButton = app.buttons["open_wikipedia_button"]
        openWikipediaButton.tap()
        
        let errorAlert = app.alerts["error_alert"]
        XCTAssertTrue(errorAlert.exists, "Error alert should be displayed")
        
        errorAlert.buttons["Ok"].tap()
    }
    
    func testErrorAlertDisplayEmptyLatLon() {
        let app = XCUIApplication()
        app.launch()
        
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
        
        app.activate()
        
        XCTAssertEqual(app.alerts.count, 0)
    }
}
