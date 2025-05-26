//
//  CityRepositoryTests.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class CityRepositoryTests: XCTestCase {
    private var repository: CityRepositoryImpl!
    private var mockDataSource: MockRemoteCityDataSource!

    override func setUp() {
        super.setUp()
        mockDataSource = MockRemoteCityDataSource()
        repository = CityRepositoryImpl(remoteDataSource: mockDataSource)
    }

    func test_searchCities_returnsMappedCities() async throws {
        let dto = CityDTO(name: "Barcelona", countryName: "Spain", adminName1: "Catalunya", toponymName: "BCN", geonameId: 1, lat: "41.4", lng: "2.1")
        mockDataSource.stubbedCities = [dto]

        let result = try await repository.searchCities(by: "Bar", offset: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Barcelona")
        XCTAssertEqual(result.first?.countryName, "Spain")
    }

    func test_searchCities_throwsError_whenDataSourceFails() async {
        mockDataSource.shouldThrowError = true

        do {
            _ = try await repository.searchCities(by: "Fails", offset: 0)
            XCTFail("Expected to throw")
        } catch {
            XCTAssertTrue(error is NSError)
        }
    }
}

