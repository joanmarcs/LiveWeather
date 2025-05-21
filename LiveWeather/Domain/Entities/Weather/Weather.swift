//
//  Weather.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct Weather {
    let temperature: String
    let description: String
    let humidity: String
    let windSpeed: String
    let forecast: [ForecastDay]
    
    static func empty() -> Weather {
            Weather(temperature: "-", description: "-", humidity: "-", windSpeed: "-", forecast: [])
    }
}
