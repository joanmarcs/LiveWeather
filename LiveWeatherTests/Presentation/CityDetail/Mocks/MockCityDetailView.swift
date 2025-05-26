//
//  MockCityDetailView.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 25/5/25.
//

import Foundation
@testable import LiveWeather

final class MockCityDetailViewProtocol: CityDetailViewProtocol {
    var receivedWeather: Weather?
    var loadingShown = false
    var errorShown = false
    var loadingStates: [Bool] = []

    func show(weather: Weather) {
        receivedWeather = weather
    }

    func showLoading(_ show: Bool) {
        loadingStates.append(show)
    }

    func showError(message: String) {
        errorShown = true
    }
}

final class MockGetWeatherUseCase: GetWeatherByLocationUseCase {
    var stubbedWeather: Weather = Weather.empty()
    var shouldThrowError = false

    func execute(lat: String, lng: String) async throws -> Weather {
        if shouldThrowError {
            throw NSError(domain: "test", code: 1)
        }
        return stubbedWeather
    }
}
