//
//  CityDetailView.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation
import UIKit

final class CityDetailView: UIView {
    enum Constant {
        static let standardMargin: CGFloat = 16
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let infoCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 12
        view.layer.masksToBounds = false
        return view
    }()
    
    public let regionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "WeatherDetailView_Title"
        return label
    }()
    
    public let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 100, weight: .ultraLight)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let currentWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let humidityStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public let humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let forecastStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    public let nextDaysLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Next days: "
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground
        
        addSubviews()
        addConstraints()
        setupContent()
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func setupContent() {
        contentView.addSubview(infoCardView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(regionNameLabel)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(currentTemperatureLabel)
        contentView.addSubview(currentWeatherDescriptionLabel)
        contentView.addSubview(humidityStackView)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(windSpeedLabel)
        infoCardView.addSubview(nextDaysLabel)
        infoCardView.addSubview(forecastStackView)
        infoCardView.isHidden = true
        
        NSLayoutConstraint.activate([
            
            regionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.standardMargin),
            regionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.standardMargin),
            regionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.standardMargin),
            
            countryNameLabel.topAnchor.constraint(equalTo: regionNameLabel.bottomAnchor, constant: 1),
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.standardMargin),
            countryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.standardMargin),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 1),
            currentTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.standardMargin),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.standardMargin),
            
            currentWeatherDescriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 1),
            currentWeatherDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.standardMargin),
            currentWeatherDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.standardMargin),
            
            humidityStackView.topAnchor.constraint(equalTo: currentWeatherDescriptionLabel.bottomAnchor, constant: 3),
            humidityStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.standardMargin),
            humidityStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.standardMargin),
            
            infoCardView.topAnchor.constraint(equalTo: humidityStackView.bottomAnchor, constant: Constant.standardMargin),
            infoCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.standardMargin),
            infoCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.standardMargin),
            infoCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.standardMargin),
            
            nextDaysLabel.topAnchor.constraint(equalTo: infoCardView.topAnchor, constant: Constant.standardMargin),
            nextDaysLabel.leadingAnchor.constraint(equalTo: infoCardView.leadingAnchor, constant: Constant.standardMargin),
            nextDaysLabel.trailingAnchor.constraint(equalTo: infoCardView.trailingAnchor, constant: -Constant.standardMargin),
            
            forecastStackView.topAnchor.constraint(equalTo: nextDaysLabel.bottomAnchor, constant: Constant.standardMargin),
            forecastStackView.leadingAnchor.constraint(equalTo: infoCardView.leadingAnchor, constant: Constant.standardMargin),
            forecastStackView.trailingAnchor.constraint(equalTo: infoCardView.trailingAnchor, constant: -Constant.standardMargin),
            forecastStackView.bottomAnchor.constraint(equalTo: infoCardView.bottomAnchor, constant: -Constant.standardMargin),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}




