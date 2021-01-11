//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 11/10/2020.
//

import UIKit

final class WeatherViewController: BaseViewController {
    
    // MARK: - IBOutlets / IBActions
    
    // My City
    @IBOutlet weak private var myCityNameLabel: UILabel!
    @IBOutlet weak private var temperatureInMyCityLabel: UILabel!
    @IBOutlet weak private var descriptionOfWeatherConditionsInMyCityLabel: UILabel!
    @IBOutlet weak private var weatherIconInMyCityUIImageView: UIImageView!
    @IBOutlet weak private var myCityIndicatorView: UIActivityIndicatorView!
    
    // Visit CIty
    @IBOutlet weak private var visitCityNameLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var descriptionOfWeatherConditionsInVisitCityLabel: UILabel!
    @IBOutlet weak private var weatherIconInVisitCityUIImageView: UIImageView!
    @IBOutlet weak private var visitCityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicatorViews(activityIndicator: myCityIndicatorView)
        setupLoadingIndicatorViews(activityIndicator: visitCityIndicatorView)
        loadMyCityWeather()
        loadVisitCityWeather()
        if #available(iOS 13.0, *) {
            visitCityIndicatorView.style = .large
         } else {
            visitCityIndicatorView.style = .whiteLarge
         }
    }
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let weatherService = WeatherService()
    private let newyorkId = "5128581"
    private let strasbourgId = "2973783"
    
    // MARK: - Methods - Private
    
    
    private func loadVisitCityWeather() {
        
        visitCityIndicatorView.startAnimating()
        
        weatherService.getWeather(cityId: newyorkId, completion: { [weak self] response in
            guard let self = self else { return }
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureLabel,
                cityNameLabel: self.visitCityNameLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsInVisitCityLabel,
                weatherInMyCityImageView: self.weatherIconInVisitCityUIImageView,
                indicatorView: self.visitCityIndicatorView
            )
        })
    }
    
    private func loadMyCityWeather() {
        
        myCityIndicatorView.startAnimating()
        
        weatherService.getWeather(cityId: strasbourgId, completion: { [weak self] response in
            guard let self = self else { return }
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureInMyCityLabel,
                cityNameLabel: self.myCityNameLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsInMyCityLabel,
                weatherInMyCityImageView: self.weatherIconInMyCityUIImageView,
                indicatorView: self.myCityIndicatorView
            )
        })
    }
    
    private func assignWeatherToLabels(
        weatherResponse: Result<WeatherResponse, NetworkManagerError>,
        temperatureLabel: UILabel,
        cityNameLabel: UILabel,
        descriptionWeatherConditionsLabel: UILabel,
        weatherInMyCityImageView: UIImageView,
        indicatorView: UIActivityIndicatorView
    ) {
        DispatchQueue.main.async {
            indicatorView.stopAnimating()
            switch weatherResponse {
            case .failure(let error):
                self.alertManagerController.presentSimpleAlert(from: self, message: error.localizedDescription)
            case .success(let response):
                self.weatherOfEachCity(
                    response: response,
                    temperatureLabel: temperatureLabel,
                    cityNameLabel: cityNameLabel,
                    descriptionWeatherConditionsLabel: descriptionWeatherConditionsLabel, weatherInMyCityImageView: weatherInMyCityImageView
                )
            }
        }
    }
    
    private func weatherOfEachCity(
        response: WeatherResponse,
        temperatureLabel: UILabel,
        cityNameLabel: UILabel,
        descriptionWeatherConditionsLabel: UILabel,
        weatherInMyCityImageView: UIImageView
    ) {
        let city = response.name
        let weatherIconName = weatherService.getImageId(iconId: response.weather?.first?.id ?? 0 )
        let currentTemperature = response.main?.temp ?? 0
        let currentTemperatureFormated = String(format: "%0.1f", currentTemperature)
        let weatherMain = response.weather?.first?.main ?? "0"
        temperatureLabel.text = "\(currentTemperatureFormated.description)°C"
        cityNameLabel.text = city?.description
        descriptionWeatherConditionsLabel.text = "\(weatherMain.description)"
        weatherInMyCityImageView.image = UIImage(named: weatherIconName)
        
    }
    
}
