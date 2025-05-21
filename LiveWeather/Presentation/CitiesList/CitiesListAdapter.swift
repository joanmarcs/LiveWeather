//
//  CitiesListAdapter.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation
import UIKit

final class CitiesListAdapter: NSObject, UITableViewDataSource {
    var cities: [City]
    private let tableView: UITableView

    init(tableView: UITableView, cities: [City] = []) {
        self.tableView = tableView
        self.cities = cities
        super.init()
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesListTableViewCell", for: indexPath) as! CitiesListTableViewCell
        let model = cities[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func append(newCities: [City]) {
        let startIndex = cities.count
        cities.append(contentsOf: newCities)
        let indexPaths = (startIndex..<cities.count).map { IndexPath(row: $0, section: 0) }
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}
