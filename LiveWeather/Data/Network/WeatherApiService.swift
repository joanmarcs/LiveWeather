//
//  WeatherApiService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

final class WeatherAPIService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWeather(lat: String, lng: String) async throws -> WeatherResponseDTO {
        let urlString = "https://wttr.in/\(lat),\(lng)?format=j1"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await session.data(from: url)
        print(String(data: data, encoding: .utf8) ?? "Invalid UTF-8")
        
        let decoder = JSONDecoder()
        return try decoder.decode(WeatherResponseDTO.self, from: data)
    }
}
