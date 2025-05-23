//
//  GeonamesApiServiceProtocol.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import Foundation

protocol GeonamesApiServiceProtocol {
    func searchCities(query: String, offset: Int) async throws -> [CityDTO]
}
