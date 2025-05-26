//
//  CityDetailPresenterTests.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 25/5/25.
//

import Foundation
import XCTest
@testable import LiveWeather

final class CityDetailPresenterTests: XCTestCase {
    private var presenter: CityDetailPresenter!
    private var mockUI: MockCityDetailViewProtocol!
    private var mockUseCase: MockGetWeatherUseCase!

    override func setUp() {
        super.setUp()
        mockUI = MockCityDetailViewProtocol()
        mockUseCase = MockGetWeatherUseCase()
        presenter = CityDetailPresenter(getWeatherUseCase: mockUseCase)
        presenter.ui = mockUI
    }

    func test_loadWeather_showsLoadingAndWeather() async {
        let weather = Weather.empty()
        mockUseCase.stubbedWeather = weather

        presenter.loadWeather(lat: "41.4", lng: "2.1")
        try? await Task.sleep(nanoseconds: 200_000_000)

        XCTAssertEqual(mockUI.loadingStates, [true, false])
        XCTAssertEqual(mockUI.receivedWeather?.temperature, weather.temperature)
        XCTAssertFalse(mockUI.errorShown)
    }

    func test_loadWeather_showsError_onFailure() async {
        mockUseCase.shouldThrowError = true

        presenter.loadWeather(lat: "error", lng: "error")
        try? await Task.sleep(nanoseconds: 200_000_000)

        XCTAssertEqual(mockUI.loadingStates, [true, false])
        XCTAssertTrue(mockUI.errorShown)
        XCTAssertNil(mockUI.receivedWeather)
    }
}
