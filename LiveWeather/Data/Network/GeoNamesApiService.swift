//
//  GeoNamesApiService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

class GeoNamesApiService {
    private let session: URLSession
    private let username = "joanmarcs"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func searchCities(query: String, offset: Int = 0) async throws -> [CityDTO] {
        guard let url = URL(string: "https://secure.geonames.org/searchJSON?name_startsWith=\(query)&startRow=\(offset)&featureClass=P&maxRows=20&username=\(username)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await session.data(from: url)
        print(String(data: data, encoding: .utf8) ?? "Invalid UTF-8")

        let decoded = try JSONDecoder().decode(GeoNamesResponse.self, from: data)

        return decoded.geonames
    }


}

struct GeoNamesResponse: Codable {
    let geonames: [CityDTO]
}
