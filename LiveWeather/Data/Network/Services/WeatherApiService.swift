//
//  WeatherApiService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class WeatherApiService: WeatherApiServiceProtocol {
    private let session: APISession

    init(session: APISession = DefaultAPISession()) {
        self.session = session
    }

    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO {
        let urlString = "https://wttr.in/\(lat),\(lng)?format=j1"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let data = try await session.get(from: url)
        return try JSONDecoder().decode(WeatherResponseDTO.self, from: data)
    }
}


