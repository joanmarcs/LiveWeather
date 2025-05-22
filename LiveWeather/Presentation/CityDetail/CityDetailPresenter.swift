//
//  CityDetailPresenter.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol CityDetailPresenterProtocol: AnyObject {
    var ui: CityDetailUI? { get set }
    
    func loadWeather(lat: String, lng: String)
    func screenTitle() -> String
}

protocol CityDetailUI: AnyObject {
    func show(weather: Weather)
    func showLoading(_ show: Bool)
    func showError(message: String)
}


final class CityDetailPresenter: CityDetailPresenterProtocol {
    weak var ui: CityDetailUI?
    private let getWeatherUseCase: GetWeatherUseCase

    init(getWeatherUseCase: GetWeatherUseCase) {
        self.getWeatherUseCase = getWeatherUseCase
    }
    
    func screenTitle() -> String {
        "Current weather"
    }

    func loadWeather(lat: String, lng: String) {
        ui?.showLoading(true)

        Task {
            do {
                let weather = try await getWeatherUseCase.execute(lat: lat, lng: lng)
                await MainActor.run {
                    self.ui?.showLoading(false)
                    self.ui?.show(weather: weather)
                }
            } catch {
                await MainActor.run {
                    self.ui?.showLoading(false)
                    self.ui?.showError(message: "Error loading weather data.")
                }
            }
        }
    }
}
