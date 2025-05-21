//
//  GetWeatherUseCase.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol GetWeatherUseCase {
    func execute(lat: String, lng: String) async throws -> Weather
}

final class GetWeatherByLocation: GetWeatherUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    public func execute(lat: String, lng: String) async throws -> Weather {
        return try await repository.getWeather(lat: lat, lng: lng)
    }
}

