//
//  WeatherResponseDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct WeatherResponseDTO: Decodable {
    let current_condition: [CurrentConditionDTO]
    let weather: [ForecastDayDTO]
    let nearest_area: [NearestAreaDTO]
}
