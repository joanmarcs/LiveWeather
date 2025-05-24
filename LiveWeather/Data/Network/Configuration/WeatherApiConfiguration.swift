//
//  WeatherApiConfiguration.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 23/5/25.
//

import Foundation

struct WeatherApiConfiguration {
    let baseURL: String
    let format: String

    static let `default` = WeatherApiConfiguration(
        baseURL: "https://wttr.in",
        format: "j1"
    )
}

