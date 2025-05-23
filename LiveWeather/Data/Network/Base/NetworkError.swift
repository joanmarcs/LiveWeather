//
//  NetworkError.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case decodingError
}
