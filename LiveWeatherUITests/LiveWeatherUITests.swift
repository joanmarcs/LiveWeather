//
//  LiveWeatherUITests.swift
//  LiveWeatherUITests
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import XCTest

final class LiveWeatherUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_searchCity_andOpenDetail() {
        let app = XCUIApplication()
        app.launch()

        let searchBar = app.searchFields["Search a place..."]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))
        searchBar.tap()
        searchBar.typeText("Madrid")

        let cell = app.tables.cells["CityCell_3117735"]
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()

        let detailLabel = app.staticTexts["WeatherDetailView_Title"]
        XCTAssertTrue(detailLabel.waitForExistence(timeout: 5))
    }

}
