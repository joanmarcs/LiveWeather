//
//  CitiesListViewController.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation
import UIKit

final class CitiesListViewController: UIViewController {
    var mainView: CitiesListView { return view as! CitiesListView  }

    var presenter: CitiesListPresenterProtocol?
    var citiesListProvider: CitiesListAdapter?

    override func loadView() {
        view = CitiesListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        citiesListProvider = CitiesListAdapter(tableView: mainView.citiesTableView)
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = mainView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        mainView.citiesTableView.delegate = self
        mainView.searchController.searchResultsUpdater = self
        mainView.searchController.searchBar.delegate = self
    }
}

extension CitiesListViewController: CitiesListViewProtocol {
    func update(cities: [City]) {
        citiesListProvider?.cities = cities
        mainView.emptyStateView.isHidden = !cities.isEmpty
        mainView.citiesTableView.reloadData()
    }
    
    func append(cities: [City]) {
        citiesListProvider?.append(newCities: cities)
    }
    
    func showEmptyState(_ show: Bool) {
        mainView.emptyStateView.isHidden = !show
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedCity = citiesListProvider?.cities[indexPath.row] else { return }
        presenter?.didSelectCity(selectedCity)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height * 1.5 {
            presenter?.loadNextPage(reset: false)
        }
    }

}

extension CitiesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        presenter?.updateSearchText(searchText)
    }
}

extension CitiesListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.cancelSearch()
    }
}
