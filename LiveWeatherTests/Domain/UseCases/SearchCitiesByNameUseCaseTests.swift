//
//  SearchCitiesByNameUseCaseTests.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 25/5/25.
//

import XCTest
@testable import LiveWeather

final class SearchCitiesByNameUseCaseTests: XCTestCase {
    private var useCase: SearchCitiesByNameUseCaseImpl!
    private var mockRepository: MockCityRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockCityRepository()
        useCase = SearchCitiesByNameUseCaseImpl(repository: mockRepository)
    }

    func test_execute_returnsCitiesFromRepository() async throws {
        let city = City(name: "Barcelona", countryName: "Spain", adminName: "Catalunya", toponymName: "BCN", geonameId: 123, lat: "41.4", lng: "2.1")
        mockRepository.stubbedCities = [city]

        let result = try await useCase.execute(query: "Bar", offset: 0)

        XCTAssertEqual(result.first?.name, city.name)
        XCTAssertEqual(result.first?.lat, city.lat)
        XCTAssertEqual(mockRepository.lastQuery, "Bar")
        XCTAssertEqual(mockRepository.lastOffset, 0)
    }

    func test_execute_throwsError_whenRepositoryFails() async {
        mockRepository.shouldThrowError = true

        do {
            _ = try await useCase.execute(query: "Error", offset: 0)
            XCTFail("Expected to throw error")
        } catch {
            XCTAssertTrue(error is NSError)
        }
    }
}

