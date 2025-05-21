//
//  GeonamesResponseDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct GeoNamesResponse: Decodable {
    let geonames: [CityDTO]
}
