//
//  MockWeatherRepository.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 25/5/25.
//

import XCTest
@testable import LiveWeather

final class MockWeatherRepository: WeatherRepository {
    var stubbedWeather: Weather = Weather.empty()
    var shouldThrowError = false
    var lastLat: String?
    var lastLng: String?

    func getWeather(lat: String, lng: String) async throws -> Weather {
        lastLat = lat
        lastLng = lng
        if shouldThrowError {
            throw NSError(domain: "test", code: 1)
        }
        return stubbedWeather
    }
}

