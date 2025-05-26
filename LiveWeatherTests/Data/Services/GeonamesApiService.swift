//
//  GeonamesApiService.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class GeonamesApiServiceTests: XCTestCase {
    private var service: GeonamesApiService!
    private var mockSession: MockApiSession!

    override func setUp() {
        super.setUp()
        mockSession = MockApiSession()
        service = GeonamesApiService(session: mockSession, config: .default)
    }

    func test_searchCities_buildsCorrectURLAndParsesResponse() async throws {
        let json = """
        {
            "geonames": [
                {
                    "name": "Barcelona",
                    "countryName": "Spain",
                    "adminName1": "Catalunya",
                    "toponymName": "BCN",
                    "geonameId": 1,
                    "lat": "41.4",
                    "lng": "2.1"
                }
            ]
        }
        """.data(using: .utf8)!

        mockSession.stubbedData = json

        let result = try await service.searchCities(query: "Bar", offset: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Barcelona")
    }
}

