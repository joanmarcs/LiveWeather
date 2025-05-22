//
//  WeatherMapper.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct WeatherMapper {
    static func map(from dto: WeatherResponseDTO) -> Weather {
        guard let current = dto.current_condition.first else {
            return Weather.empty()
        }

        let forecast = dto.weather.map {
            ForecastDay(
                date: $0.date,
                maxTemp: $0.maxtempC,
                minTemp: $0.mintempC
            )
        }
        
        let location = dto.nearest_area.first.map {
            WeatherLocation(
                regionName: $0.areaName.first?.value ?? "",
                countryName: $0.country.first?.value ?? ""
            )
        } ?? WeatherLocation(regionName: "", countryName: "")

        
        let weather = Weather(
            temperature: current.temp_C,
            description: current.weatherDesc.first?.value ?? "",
            humidity: current.humidity,
            windSpeed: current.windspeedKmph,
            forecast: forecast,
            location: location
        )

        return weather
    }
}
