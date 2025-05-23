//
//  RemoteWeatherDataSource.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import Foundation

protocol RemoteWeatherDataSourceProtocol {
    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO
}

final class RemoteWeatherDataSource: RemoteWeatherDataSourceProtocol {
    private let apiService: WeatherApiServiceProtocol

    init(apiService: WeatherApiServiceProtocol) {
        self.apiService = apiService
    }

    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO {
        try await apiService.fetchWeather(lat: lat, lng: lng)
    }
}
