//
//  CityMapper.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct CityMapper {
    static func map(from dto: CityDTO) -> City {
        City(name: dto.name, countryName: dto.countryName, adminName: dto.adminName1, toponymName: dto.toponymName, geonameId: dto.geonameId, lat: dto.lat, lng: dto.lng)
    }
}
