//
//  CitiesListView.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation
import UIKit

final class CitiesListView: UIView {
    enum Constant {
        static let estimatedRowHeight: CGFloat = 120
    }
    
    let citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: "CitiesListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search a place..."
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    let emptyStateView: UILabel = {
        let label = UILabel()
        label.text = "Search your city to see the upcoming weather"
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(citiesTableView)
        addSubview(emptyStateView)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            citiesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            citiesTableView.topAnchor.constraint(equalTo: topAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
}
