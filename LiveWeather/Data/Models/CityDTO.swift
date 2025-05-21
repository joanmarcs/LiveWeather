//
//  CityDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct CityDTO: Codable {
    let name: String
    let countryName: String
    let adminName1: String
    let toponymName: String
}

extension CityDTO {
    func toDomain() -> City {
        City(name: name, countryName: countryName, adminName: adminName1, toponymName: toponymName)
    }
}
