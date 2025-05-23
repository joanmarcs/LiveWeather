//
//  SearchCityByNameUseCase.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol SearchCitiesByNameUseCase {
    func execute(query: String, offset: Int) async throws -> [City]
}

final class SearchCitiesByNameUseCaseImpl: SearchCitiesByNameUseCase {
    private let repository: CityRepository
    
    init(repository: CityRepository) {
        self.repository = repository
    }
    
    public func execute(query: String, offset: Int) async throws -> [City]  {
        return try await repository.searchCities(by: query, offset: offset)
    }
}
