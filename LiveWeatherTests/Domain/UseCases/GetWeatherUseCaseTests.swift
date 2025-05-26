//
//  GetWeatherUseCaseTests.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 25/5/25.
//

import XCTest
@testable import LiveWeather

final class GetWeatherUseCaseTests: XCTestCase {
    private var useCase: GetWeatherByLocationUseCaseImpl!
    private var mockRepository: MockWeatherRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockWeatherRepository()
        useCase = GetWeatherByLocationUseCaseImpl(repository: mockRepository)
    }

    func test_execute_returnsWeatherFromRepository() async throws {
        let expectedWeather = Weather.empty()
        mockRepository.stubbedWeather = expectedWeather

        let result = try await useCase.execute(lat: "41.4", lng: "2.1")

        XCTAssertEqual(result.temperature, expectedWeather.temperature)
        XCTAssertEqual(result.description, expectedWeather.description)
        XCTAssertEqual(result.humidity, expectedWeather.humidity)
        XCTAssertEqual(result.windSpeed, expectedWeather.windSpeed)
        XCTAssertEqual(result.location.regionName, expectedWeather.location.regionName)
        XCTAssertEqual(result.location.countryName, expectedWeather.location.countryName)
        XCTAssertEqual(result.forecast.count, expectedWeather.forecast.count)

        XCTAssertEqual(mockRepository.lastLat, "41.4")
        XCTAssertEqual(mockRepository.lastLng, "2.1")
    }

    func test_execute_throwsError_whenRepositoryFails() async {
        mockRepository.shouldThrowError = true

        do {
            _ = try await useCase.execute(lat: "x", lng: "y")
            XCTFail("Expected to throw")
        } catch {
            XCTAssertTrue(error is NSError)
        }
    }
}
