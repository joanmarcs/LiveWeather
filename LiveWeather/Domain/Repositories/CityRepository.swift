//
//  CityRepository.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol CityRepository {
    func searchCities(by name: String, offset: Int) async throws -> [City]
}
