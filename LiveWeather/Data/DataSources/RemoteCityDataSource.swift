//
//  RemoteCityDataSource.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol RemoteCityDataSourceProtocol {
    func searchCities(query: String, offset: Int) async throws -> [CityDTO]
}

class RemoteCityDataSource: RemoteCityDataSourceProtocol {
    private let apiService: GeoNamesApiService

    init(apiService: GeoNamesApiService) {
        self.apiService = apiService
    }

    func searchCities(query: String, offset: Int) async throws -> [CityDTO] {
        return try await apiService.searchCities(query: query, offset: offset)
    }
}
