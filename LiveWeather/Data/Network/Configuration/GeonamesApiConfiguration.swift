//
//  GeonamesApiConfiguration.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 23/5/25.
//

import Foundation

struct GeonamesApiConfiguration {
    let baseURL: String
    let username: String
    let maxRows: Int

    static let `default` = GeonamesApiConfiguration(
        baseURL: "https://secure.geonames.org/searchJSON",
        username: "joanmarcs",
        maxRows: 20
    )
}
