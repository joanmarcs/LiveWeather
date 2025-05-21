//
//  CurrentConditionDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct CurrentConditionDTO: Decodable {
    let temp_C: String
    let weatherDesc: [WeatherDescriptionDTO]
    let humidity: String
    let windspeedKmph: String
}
