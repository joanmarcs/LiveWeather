//
//  WeatherApiService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class WeatherApiService: WeatherApiServiceProtocol {
    private let session: ApiSession
    private let config: WeatherApiConfiguration

    init(
        session: ApiSession = DefaultApiSession(),
        config: WeatherApiConfiguration = .default
    ) {
        self.session = session
        self.config = config
    }

    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO {
        let urlString = "\(config.baseURL)/\(lat),\(lng)?format=\(config.format)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let data = try await session.get(from: url)
        return try JSONDecoder().decode(WeatherResponseDTO.self, from: data)
    }
}



