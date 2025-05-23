//
//  GetWeatherUseCase.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol GetWeatherByLocationUseCase {
    func execute(lat: String, lng: String) async throws -> Weather
}

final class GetWeatherByLocationUseCaseImpl: GetWeatherByLocationUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    public func execute(lat: String, lng: String) async throws -> Weather {
        return try await repository.getWeather(lat: lat, lng: lng)
    }
}

