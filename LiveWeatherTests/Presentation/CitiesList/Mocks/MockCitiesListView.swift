//
//  MockCitiesListView.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 24/5/25.
//

import Foundation
@testable import LiveWeather

final class MockCitiesListView: CitiesListViewProtocol {
    var updatedCitiesCalledWith: [City] = []
    var appendedCities: [City] = []
    var emptyStateShown = false
    var appendCalledCount = 0

    func update(cities: [City]) {
        updatedCitiesCalledWith = cities
    }

    func append(cities: [City]) {
        appendedCities = cities
        appendCalledCount += 1
    }

    func showEmptyState(_ show: Bool) {
        emptyStateShown = show
    }
}

final class MockSearchCitiesUseCase: SearchCitiesByNameUseCase {
    var stubbedCities: [City] = []
    var shouldThrowError = false

    func execute(query: String, offset: Int) async throws -> [City] {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return stubbedCities
    }
}


