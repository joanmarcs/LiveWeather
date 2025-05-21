//
//  ForecastDayDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct ForecastDayDTO: Decodable {
    let date: String
    let maxtempC: String
    let mintempC: String
}
