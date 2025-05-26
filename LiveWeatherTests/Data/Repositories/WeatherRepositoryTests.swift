//
//  WeatherRepositoryTests.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class WeatherRepositoryTests: XCTestCase {
    private var repository: WeatherRepositoryImpl!
    private var mockDataSource: MockRemoteWeatherDataSource!

    override func setUp() {
        super.setUp()
        mockDataSource = MockRemoteWeatherDataSource()
        repository = WeatherRepositoryImpl(dataSource: mockDataSource)
    }

    func test_getWeather_returnsMappedWeather() async throws {
        let dto = WeatherResponseDTO(
            current_condition: [
                CurrentConditionDTO(
                    temp_C: "18",
                    weatherDesc: [WeatherDescriptionDTO(value: "Cloudy")],
                    humidity: "55",
                    windspeedKmph: "10"
                )
            ],
            weather: [
                ForecastDayDTO(date: "2024-05-24", maxtempC: "20", mintempC: "14")
            ],
            nearest_area: [
                NearestAreaDTO(
                    areaName: [WeatherAreaNameDTO(value: "Barcelona")],
                    country: [WeatherCountryDTO(value: "Spain")]
                )
            ]
        )

        mockDataSource.stubbedDTO = dto

        let result = try await repository.getWeather(lat: "41.4", lng: "2.1")

        XCTAssertEqual(result.temperature, "18")
        XCTAssertEqual(result.description, "Cloudy")
        XCTAssertEqual(result.humidity, "55")
        XCTAssertEqual(result.windSpeed, "10")
        XCTAssertEqual(result.location.regionName, "Barcelona")
        XCTAssertEqual(result.location.countryName, "Spain")
        XCTAssertEqual(result.forecast.first?.date, "2024-05-24")
    }

    func test_getWeather_throwsError_whenDataSourceFails() async {
        mockDataSource.shouldThrowError = true

        do {
            _ = try await repository.getWeather(lat: "fail", lng: "fail")
            XCTFail("Expected to throw")
        } catch {
            XCTAssertTrue(error is NSError)
        }
    }
}

