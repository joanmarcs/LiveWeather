//
//  NearestAreaDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct NearestAreaDTO: Decodable {
    let areaName: [WeatherAreaNameDTO]
    let country: [WeatherCountryDTO]
}
