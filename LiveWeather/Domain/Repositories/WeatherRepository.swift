//
//  WeatherRepository.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol WeatherRepository {
    func getWeather(lat: String, lng: String) async throws -> Weather
}

