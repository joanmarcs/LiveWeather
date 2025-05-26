//
//  MockCitiesRepository.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 25/5/25.
//


import Foundation
@testable import LiveWeather

final class MockCityRepository: CityRepository {
    var stubbedCities: [City] = []
    var shouldThrowError = false
    var lastQuery: String?
    var lastOffset: Int?

    func searchCities(by name: String, offset: Int) async throws -> [City] {
        lastQuery = name
        lastOffset = offset
        if shouldThrowError {
            throw NSError(domain: "test", code: 1)
        }
        return stubbedCities
    }
}

