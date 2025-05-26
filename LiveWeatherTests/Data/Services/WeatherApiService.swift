//
//  WeatherApiService.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class WeatherApiServiceTests: XCTestCase {
    private var service: WeatherApiService!
    private var mockSession: MockApiSession!

    override func setUp() {
        super.setUp()
        mockSession = MockApiSession()
        service = WeatherApiService(session: mockSession, config: .default)
    }

    func test_fetchWeather_parsesWeatherResponseCorrectly() async throws {
        let json = """
        {
            "current_condition": [
                {
                    "temp_C": "22",
                    "weatherDesc": [{ "value": "Sunny" }],
                    "humidity": "40",
                    "windspeedKmph": "15"
                }
            ],
            "weather": [
                { "date": "2024-05-24", "maxtempC": "25", "mintempC": "16" }
            ],
            "nearest_area": [
                {
                    "areaName": [{ "value": "Barcelona" }],
                    "country": [{ "value": "Spain" }]
                }
            ]
        }
        """.data(using: .utf8)!

        mockSession.stubbedData = json

        let result = try await service.fetchWeather(lat: "41.4", lng: "2.1")

        XCTAssertEqual(result.current_condition.first?.temp_C, "22")
        XCTAssertEqual(result.weather.first?.date, "2024-05-24")
        XCTAssertEqual(result.nearest_area.first?.country.first?.value, "Spain")
    }

    func test_fetchWeather_throws_whenResponseIsInvalid() async {
        mockSession.stubbedData = "{}".data(using: .utf8)!

        do {
            _ = try await service.fetchWeather(lat: "x", lng: "y")
            XCTFail("Expected decoding to fail")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}

