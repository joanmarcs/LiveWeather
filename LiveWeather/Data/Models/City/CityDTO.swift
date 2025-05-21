//
//  CityDTO.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

struct CityDTO: Decodable {
    let name: String
    let countryName: String
    let adminName1: String
    let toponymName: String
    let geonameId: Int
    let lat: String
    let lng: String
}
