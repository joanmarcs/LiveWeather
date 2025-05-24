//
//  ApiSession.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import Foundation

protocol ApiSession {
    func get(from url: URL) async throws -> Data
}

final class DefaultApiSession: ApiSession {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func get(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
