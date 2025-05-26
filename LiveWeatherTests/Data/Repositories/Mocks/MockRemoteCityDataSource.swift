//
//  MockRemoteCityDataSource.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class MockRemoteCityDataSource: RemoteCityDataSourceProtocol {
    var stubbedCities: [CityDTO] = []
    var shouldThrowError = false

    func searchCities(query: String, offset: Int) async throws -> [CityDTO] {
        if shouldThrowError {
            throw NSError(domain: "test", code: 1)
        }
        return stubbedCities
    }
}

