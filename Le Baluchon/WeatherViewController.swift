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
    
    private let networkManager = NetworkManager()
    
    
    private let newyorkId = "5128581"
    private let strasbourgId = "2973783"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeather(cityId: strasbourgId, completion: { response in
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureInMyCityLabel,
                cityNameLabel: self.myCityLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsInMyCityLabel
            )
            
        })
        
        getWeather(cityId: newyorkId, completion: { response in
            self.assignWeatherToLabels(
                weatherResponse: response,
                temperatureLabel: self.temperatureLabel,
                cityNameLabel: self.visitCityLabel,
                descriptionWeatherConditionsLabel: self.descriptionOfWeatherConditionsLabel
            )
            
        })
        
       
    }
    
    private func getWeather<T: Codable>(cityId: String, completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        guard let url = getWeatherURL(cityId: cityId) else {
            completion(.failure(.couldNotCreateUrl))
            return
            
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
    
    private func getWeatherURL(cityId: String) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: cityId),
            URLQueryItem(name: "appid", value: "2c0724a7707cee690f3818f2bb142711"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        return urlComponents.url
//        return URL(string: urlString)
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
                print(error.localizedDescription)
                
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
    
    private func weatherOfEachCity(response: WeatherResponse, temperatureLabel: UILabel, cityNameLabel: UILabel, descriptionWeatherConditionsLabel: UILabel) {
        let city = response.name
        let humidity = response.main?.humidity ?? 0
        let currentTemperature = response.main?.temp ?? 0
        //let currentWeatherDescription = response.weather?.description
        //ici nv ibOutlet
        temperatureLabel.text = "\(currentTemperature.description)°C"
        cityNameLabel.text = city?.description
        descriptionWeatherConditionsLabel.text = "Humidity: \(humidity.description)"
        
    }
    
    
}
