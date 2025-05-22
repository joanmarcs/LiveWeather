//
//  AppCoordinator.swift
//  LiveWeather
//
//  Created by Joan Marc Sanahuja on 22/5/25.
//

import UIKit

final class AppCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let cityListVC = buildCityList()
        navigationController.pushViewController(cityListVC, animated: false)
    }

    private func buildCityList() -> UIViewController {
        let geoNamesService = GeoNamesApiService()
        let dataSource = RemoteCityDataSource(apiService: geoNamesService)
        let repository = CityRepositoryImpl(remoteDataSource: dataSource)
        let useCase = SearchCities(repository: repository)
        let presenter = CitiesListPresenter(getCitiesUseCase: useCase)
        let vc = CitiesListViewController()
        vc.presenter = presenter
        presenter.coordinator = self
        return vc
    }

    func showCityDetail(for city: City) {
        let weatherService = WeatherAPIService()
        let weatherRepository = WeatherRepositoryImpl(apiService: weatherService)
        let useCase = GetWeatherByLocation(repository: weatherRepository)
        let presenter = CityDetailPresenter(getWeatherUseCase: useCase)
        let vc = CityDetailViewController(city: city, presenter: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
}

