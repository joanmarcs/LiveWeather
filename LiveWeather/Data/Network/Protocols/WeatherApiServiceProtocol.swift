//
//  WeatherApiServiceProtocol.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import Foundation

protocol WeatherApiServiceProtocol {
    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO
}
