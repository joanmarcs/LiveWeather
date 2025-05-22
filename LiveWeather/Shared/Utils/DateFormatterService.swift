//
//  DateFormatterService.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import Foundation

final class DateFormatterService {
    static let shared = DateFormatterService()

    private let inputFormatter: DateFormatter
    private let outputFormatter: DateFormatter

    private init() {
        inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE, d MMMM"
        outputFormatter.locale = Locale(identifier: "en_US")
    }

    func formatDate(from string: String) -> String {
        guard let date = inputFormatter.date(from: string) else {
            return string
        }
        return outputFormatter.string(from: date).capitalized
    }
}

