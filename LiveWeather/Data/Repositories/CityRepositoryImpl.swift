//
//  CityRepositoryImpl.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class CityRepositoryImpl: CityRepository {
    private let remoteDataSource: RemoteCityDataSourceProtocol

    init(remoteDataSource: RemoteCityDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func searchCities(by name: String, offset: Int) async throws -> [City] {
        let dtos = try await remoteDataSource.searchCities(query: name, offset: offset)
        return dtos.map { $0.toDomain() }
    }
}
