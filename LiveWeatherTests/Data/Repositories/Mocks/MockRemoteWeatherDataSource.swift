//
//  MockRemoteWeatherDataSource.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class MockRemoteWeatherDataSource: RemoteWeatherDataSourceProtocol {
    var stubbedDTO: WeatherResponseDTO = WeatherResponseDTO(
        current_condition: [],
        weather: [],
        nearest_area: []
    )

    var shouldThrowError = false

    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO {
        if shouldThrowError {
            throw NSError(domain: "test", code: 1)
        }
        return stubbedDTO
    }
}

