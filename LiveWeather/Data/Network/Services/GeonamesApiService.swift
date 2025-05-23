//
//  GeoNamesApiService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class GeonamesApiService: GeonamesApiServiceProtocol {
    private let session: APISession
    private let username = "joanmarcs"

    init(session: APISession = DefaultAPISession()) {
        self.session = session
    }

    func searchCities(query: String, offset: Int = 0) async throws -> [CityDTO] {
        let urlString = "https://secure.geonames.org/searchJSON?name_startsWith=\(query)&startRow=\(offset)&featureClass=P&maxRows=20&username=\(username)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let data = try await session.get(from: url)
        return try JSONDecoder().decode(GeoNamesResponse.self, from: data).geonames
    }
}
