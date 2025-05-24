//
//  GeoNamesApiService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class GeonamesApiService: GeonamesApiServiceProtocol {
    private let session: ApiSession
    private let config: GeonamesApiConfiguration

    init(
        session: ApiSession = DefaultApiSession(),
        config: GeonamesApiConfiguration = .default
    ) {
        self.session = session
        self.config = config
    }

    func searchCities(query: String, offset: Int = 0) async throws -> [CityDTO] {
        var components = URLComponents(string: config.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "name_startsWith", value: query),
            URLQueryItem(name: "startRow", value: "\(offset)"),
            URLQueryItem(name: "featureClass", value: "P"),
            URLQueryItem(name: "maxRows", value: "\(config.maxRows)"),
            URLQueryItem(name: "username", value: config.username)
        ]

        guard let url = components?.url else {
            throw NetworkError.badURL
        }

        let data = try await session.get(from: url)
        return try JSONDecoder().decode(GeoNamesResponse.self, from: data).geonames
    }
}
