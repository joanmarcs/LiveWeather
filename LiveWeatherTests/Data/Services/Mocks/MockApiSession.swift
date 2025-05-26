//
//  MockApiSession.swift
//  LiveWeatherTests
//
//  Created by Joan Marc Sanahuja on 26/5/25.
//

import XCTest
@testable import LiveWeather

final class MockApiSession: ApiSession {
    var stubbedData: Data?

    func get(from url: URL) async throws -> Data {
        guard let data = stubbedData else {
            throw NSError(domain: "test", code: 1)
        }
        return data
    }
}


