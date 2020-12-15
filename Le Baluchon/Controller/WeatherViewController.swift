//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 11/10/2020.
//

import UIKit

class WeatherViewController: BaseViewController {
    
    @IBOutlet weak var myCityLabel: UILabel!
    @IBOutlet weak var temperatureInMyCityLabel: UILabel!
    @IBOutlet weak var descriptionOfWeatherConditionsInMyCityLabel: UILabel!
    @IBOutlet weak var weatherInMyCityImageView: UIImageView!
    @IBOutlet weak var weatherInVisitCityImageView: UIImageView!
    @IBOutlet weak var visitCityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionOfWeatherConditionsLabel: UILabel!
    
    private let weatherService = WeatherService()
    
    
    private let newyorkId = "5128581"
    private let strasbourgId = "2973783"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.getWeather(cityId: strasbourgId, completion: { response in
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureInMyCityLabel,
                cityNameLabel: self.myCityLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsInMyCityLabel, weatherInMyCityImageView: self.weatherInMyCityImageView
            )
            
        })
        
        weatherService.getWeather(cityId: newyorkId, completion: { response in
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureLabel,
                cityNameLabel: self.visitCityLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsLabel, weatherInMyCityImageView: self.weatherInVisitCityImageView
            )
            
        })
        
        
    }
    
    private func assignWeatherToLabels(
        weatherResponse: Result<WeatherResponse, NetworkManagerError>,
        temperatureLabel: UILabel,
        cityNameLabel: UILabel,
        descriptionWeatherConditionsLabel: UILabel,
        weatherInMyCityImageView: UIImageView
    ) { // Change currency response
        
        DispatchQueue.main.async {
            
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
