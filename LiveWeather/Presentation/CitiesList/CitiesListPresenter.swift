//
//  CitiesListPresenter.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 21/5/25.
//

import Foundation

protocol CitiesListPresenterProtocol: AnyObject {
    var ui: ListCitiesUI? { get set }
    
    func screenTitle() -> String
    func updateSearchText(_ searchText: String)
    func cancelSearch()
    func loadNextPage(reset: Bool)
}

protocol ListCitiesUI: AnyObject {
    func update(cities: [City])
    func append(cities: [City])
    func showEmptyState(_ show: Bool)
}

final class CitiesListPresenter: CitiesListPresenterProtocol {
    weak var ui: ListCitiesUI?
    private let getCitiesUseCase: SearchCitiesByNameUseCase
    
    private var currentPage = 0
    private var isLoading = false
    private let rowsPerPage = 20
    private var currentQuery = ""
    private var hasMoreResults = true

    init(getCitiesUseCase: SearchCitiesByNameUseCase) {
        self.getCitiesUseCase = getCitiesUseCase
    }

    func screenTitle() -> String {
        "Your city weather app"
    }
    
    func updateSearchText(_ searchText: String) {
        if searchText.isEmpty {
            self.ui?.update(cities: [])
            self.ui?.showEmptyState(true)
        } else if searchText != currentQuery {
            currentQuery = searchText.trimmingCharacters(in: .whitespaces)
            currentPage = 0
            loadNextPage(reset: true)
            hasMoreResults = true
        }
    }
    
    func loadNextPage(reset: Bool = false) {
        guard !isLoading, !currentQuery.isEmpty, hasMoreResults else { return }
        isLoading = true

        Task {
            do {
                let results = try await getCitiesUseCase.execute(query: currentQuery, offset: currentPage * rowsPerPage)
                await MainActor.run {
                    if reset {
                        ui?.update(cities: results)
                    } else {
                        ui?.append(cities: results)
                    }
                    hasMoreResults = results.count == rowsPerPage
                    ui?.showEmptyState(results.isEmpty && reset)
                    currentPage += 1
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    if reset { ui?.update(cities: []) }
                    ui?.showEmptyState(true)
                    isLoading = false
                }
            }
        }
    }
    
    func cancelSearch() {
        currentQuery = ""
        self.ui?.update(cities: [])
        self.ui?.showEmptyState(true)
    }
}
