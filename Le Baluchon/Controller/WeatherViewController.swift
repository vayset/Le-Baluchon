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
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsInMyCityLabel
            )
            
        })
    
        weatherService.getWeather(cityId: newyorkId, completion: { response in
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureLabel,
                cityNameLabel: self.visitCityLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsLabel
            )
            
        })
        
       
    }
    
   
    
    private func assignWeatherToLabels(
        weatherResponse: Result<WeatherResponse, NetworkManagerError>,
        temperatureLabel: UILabel,
        cityNameLabel: UILabel,
        descriptionWeatherConditionsLabel: UILabel
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
                    descriptionWeatherConditionsLabel: descriptionWeatherConditionsLabel
                )
            }
            
            
        }
        
    }
    
    func weatherImage(humidity: Int)  {
        if humidity < 50 {
            self.weatherInMyCityImageView.image = UIImage(named: "sunn")
            self.weatherInVisitCityImageView.image = UIImage(named: "sunn")
        } else {
            self.weatherInMyCityImageView.image = UIImage(named: "cloudRain")
            self.weatherInVisitCityImageView.image = UIImage(named: "cloudRain")
        }
    }
    
    private func weatherOfEachCity(response: WeatherResponse, temperatureLabel: UILabel, cityNameLabel: UILabel, descriptionWeatherConditionsLabel: UILabel) {
        let city = response.name
        let humidity = response.main?.humidity ?? 0
        let currentTemperature = response.main?.temp ?? 0
        let weatherMain = response.weather?.first?.main ?? "0"
        temperatureLabel.text = "\(currentTemperature.description)°C"
        cityNameLabel.text = city?.description
        descriptionWeatherConditionsLabel.text = "\(weatherMain.description)"
        weatherImage(humidity: humidity)
        
    }
    
    
}
