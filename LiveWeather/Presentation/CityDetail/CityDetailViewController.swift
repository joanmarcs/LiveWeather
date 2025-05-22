//
//  CityDetailViewController.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation
import UIKit

final class CityDetailViewController: UIViewController {
    private let presenter: CityDetailPresenterProtocol?
    private let city: City

    var mainView: CityDetailView { view as! CityDetailView }

    init(city: City, presenter: CityDetailPresenterProtocol) {
        self.city = city
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = CityDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.ui = self
        presenter?.loadWeather(lat: city.lat, lng: city.lng)
        
        title = presenter?.screenTitle()
    }
}

extension CityDetailViewController: CityDetailUI {
    func showLoading(_ show: Bool) {
        show ? mainView.activityIndicator.startAnimating() : mainView.activityIndicator.stopAnimating()
    }

    func show(weather: Weather) {
        mainView.infoCardView.isHidden = false
        mainView.humidityLabel.text = "Humidity: \(weather.humidity)%"
        mainView.windSpeedLabel.text = "Wind: \(weather.windSpeed) km/h"
        
        mainView.countryNameLabel.text = "\(weather.location.countryName)"
        mainView.regionNameLabel.text = "\(weather.location.regionName)"
        mainView.currentTemperatureLabel.text = " \(weather.temperature)°"
        mainView.currentWeatherDescriptionLabel.text = "\(weather.description)"

        mainView.forecastStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        weather.forecast.forEach { day in
            let formattedDate = DateFormatterService.shared.formatDate(from: day.date)
            
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .label
            label.text = "\(formattedDate): max \(day.maxTemp)°C, min \(day.minTemp)°C"
            mainView.forecastStackView.addArrangedSubview(label)
        }
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


