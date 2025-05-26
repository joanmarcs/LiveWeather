//
//  CitiesListPresenterTests.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 24/5/25.
//

import XCTest
@testable import LiveWeather

final class CitiesListPresenterTests: XCTestCase {
    private var presenter: CitiesListPresenter!
    private var mockUI: MockCitiesListView!
    private var mockUseCase: MockSearchCitiesUseCase!

    override func setUp() {
        super.setUp()
        mockUI = MockCitiesListView()
        mockUseCase = MockSearchCitiesUseCase()
        presenter = CitiesListPresenter(getCitiesUseCase: mockUseCase)
        presenter.ui = mockUI
    }

    func test_updateSearchText_withEmpty_shouldShowEmptyState() {
        presenter.updateSearchText("")

        XCTAssertTrue(mockUI.updatedCitiesCalledWith.isEmpty)
        XCTAssertTrue(mockUI.emptyStateShown)
    }

    func test_updateSearchText_withQuery_shouldLoadCities() async {
        mockUseCase.stubbedCities = [City(name: "Paris", countryName: "France", adminName: "", toponymName: "", geonameId: 0, lat: "0", lng: "0")]

        presenter.updateSearchText("Par")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(mockUI.updatedCitiesCalledWith.count, 1)
        XCTAssertFalse(mockUI.emptyStateShown)
    }

    func test_cancelSearch_shouldClearCitiesAndShowEmpty() {
        presenter.cancelSearch()

        XCTAssertTrue(mockUI.updatedCitiesCalledWith.isEmpty)
        XCTAssertTrue(mockUI.emptyStateShown)
    }
    
    func test_loadNextPage_appendsCities_whenHasMoreResults() async {
        let city = City(name: "Berlin", countryName: "Germany", adminName: "", toponymName: "", geonameId: 1, lat: "1", lng: "1")
        mockUseCase.stubbedCities = Array(repeating: city, count: 20)

        presenter.updateSearchText("Berlin")
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        presenter.loadNextPage(reset: false)
        try? await Task.sleep(nanoseconds: 200_000_000)

        XCTAssertEqual(mockUI.appendedCities.count, 20)
    }

    
    func test_loadNextPage_doesNotAppend_whenNoMoreResults() async {
        let city = City(name: "Paris", countryName: "France", adminName: "", toponymName: "", geonameId: 0, lat: "0", lng: "0")
        mockUseCase.stubbedCities = [city]

        presenter.updateSearchText("Paris")
        try? await Task.sleep(nanoseconds: 100_000_000)

        mockUI.appendCalledCount = 0
        presenter.loadNextPage(reset: false)
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(mockUI.appendCalledCount, 0, "append() should not be called if there are no more results")
    }

    
    func test_loadNextPage_showsEmptyState_onFailure() async {
        mockUseCase.shouldThrowError = true
        presenter.updateSearchText("Error")
        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertTrue(mockUI.emptyStateShown)
    }
}

