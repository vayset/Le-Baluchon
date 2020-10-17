//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 11/10/2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var myCityLabel: UILabel!
    @IBOutlet weak var temperatureInMyCityLabel: UILabel!
    @IBOutlet weak var descriptionOfWeatherConditionsInMyCityLabel: UILabel!
    @IBOutlet weak var visitCityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionOfWeatherConditionsLabel: UILabel!
    
    @IBOutlet weak var weatherImageOutlet: UIImageView!
    
    private let networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        getWeather(cityId: "5128581")
        getWeather(cityId: "2973783")
        
    }
    
//    func getMyCityWeather(cityId: String) {
//        let urlString = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=2c0724a7707cee690f3818f2bb142711&units=metric" // utilise l'utl corresponsdante à l'API weather
//
//        let url = URL(string: urlString)!
//        networkManager.fetch(url: url, completion: assignWeatherOnMyCityToLabel)
//    }
    
    func getWeather(cityId: String) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?id=5128581&appid=2c0724a7707cee690f3818f2bb142711&units=metric" // utilise l'utl corresponsdante à l'API weather
        let urlMyCityString = "http://api.openweathermap.org/data/2.5/weather?id=2973783&appid=2c0724a7707cee690f3818f2bb142711&units=metric"
        let myCityUrl = URL(string: urlMyCityString)!
        
        let url = URL(string: urlString)!
        networkManager.fetch(url: url, completion: assignWeatherToLabel)
        networkManager.fetch(url: myCityUrl, completion: assignWeatherOnMyCityToLabel)

    }
    
    func assignWeatherOnMyCityToLabel(currencyResponse: Result<WeatherResponse, NetworkManagerError>) { // Change currency response
        
        DispatchQueue.main.async {
            
            switch currencyResponse {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                self.weatherOfEachCity(response: response, temperature: self.temperatureInMyCityLabel, cityName: self.myCityLabel, descriptionWeatherConditions: self.descriptionOfWeatherConditionsInMyCityLabel)
            }
            
            
        }
        
    }
    
    func assignWeatherToLabel(currencyResponse: Result<WeatherResponse, NetworkManagerError>) { // Change currency response
        
        DispatchQueue.main.async {
            
            switch currencyResponse {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                self.weatherOfEachCity(response: response, temperature: self.visitCityLabel, cityName: self.visitCityLabel, descriptionWeatherConditions: self.descriptionOfWeatherConditionsLabel)
            }
            
            
        }
        
    }
    
    func weatherOfEachCity(response: WeatherResponse, temperature: UILabel, cityName: UILabel, descriptionWeatherConditions: UILabel) {
        let city = response.name
        let humidity = response.main.humidity
        let currentTemperature = response.main.temp
        temperature.text = "\(currentTemperature.description)°C"
        cityName.text = city.description
        descriptionWeatherConditions.text = humidity.description
        if humidity > 50 {
            self.weatherImageOutlet.image = UIImage(named: "weather")
        }
    }
    
}
