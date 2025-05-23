//
//  WeatherRepositoryImpl.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    private let dataSource: RemoteWeatherDataSourceProtocol

    init(dataSource: RemoteWeatherDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getWeather(lat: String, lng: String) async throws -> Weather {
        let dto = try await dataSource.fetchWeather(lat: lat, lng: lng)
        return WeatherMapper.map(from: dto)
    }
}

