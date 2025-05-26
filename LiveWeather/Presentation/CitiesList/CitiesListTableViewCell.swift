//
//  CitiesListTableViewCell.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation
import UIKit

final class CitiesListTableViewCell: UITableViewCell {
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(cityNameLabel)
        addSubview(countryNameLabel)
        addSubview(locationCodeLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            countryNameLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 8),
            countryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            countryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            countryNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            locationCodeLabel.centerYAnchor.constraint(equalTo: countryNameLabel.centerYAnchor),
            locationCodeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }

    
    func configure(model: City) {
        cityNameLabel.text = model.name + " (\(model.toponymName))"
        countryNameLabel.text = model.adminName + " - " + model.countryName
        locationCodeLabel.text = "\(model.lat), \(model.lng)"
        accessibilityIdentifier = "CityCell_\(model.geonameId)"

    }
}
