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
        let geonamesService: GeonamesApiServiceProtocol = GeonamesApiService()
        let dataSource: RemoteCityDataSourceProtocol = RemoteCityDataSource(apiService: geonamesService)
        let repository = CityRepositoryImpl(remoteDataSource: dataSource)
        let useCase = SearchCitiesByNameUseCaseImpl(repository: repository)
        let presenter = CitiesListPresenter(getCitiesUseCase: useCase)
        let vc = CitiesListViewController()
        vc.presenter = presenter
        presenter.coordinator = self
        return vc
    }

    func showCityDetail(for city: City) {
        let weatherService: WeatherApiServiceProtocol = WeatherApiService()
        let weatherDataSource: RemoteWeatherDataSourceProtocol = RemoteWeatherDataSource(apiService: weatherService)
        let weatherRepository: WeatherRepository = WeatherRepositoryImpl(dataSource: weatherDataSource)
        let useCase = GetWeatherByLocationUseCaseImpl(repository: weatherRepository)
        let presenter = CityDetailPresenter(getWeatherUseCase: useCase)
        let vc = CityDetailViewController(city: city, presenter: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
}

