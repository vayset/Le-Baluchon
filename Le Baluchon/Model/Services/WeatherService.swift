//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 19/11/2020.
//

import Foundation


enum WeatherServiceError: Error {
    case couldNotGetImage
}

class WeatherService {
    
    // MARK: - Internal
    
    // MARK: Methods - Internal
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        urlComponents: UrlComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.urlComponents = urlComponents
    }
    
    func getWeather(cityId: String, completion: @escaping (Result<WeatherResponse, NetworkManagerError>) -> Void) {
        guard let url = getWeatherURL(cityId: cityId) else {
            completion(.failure(.couldNotCreateUrl))
            return
            
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
    
     func getImageId(iconId: Int) -> String {
        
        switch iconId {
        case 200...232: return "thunderstorm"
        case 300...321: return "drizzle"
        case 500...531: return "rain"
        case 600...622: return "snow"
        case 701...781: return "atmosphere"
        case 800: return "clear"
        case 801...804: return "clouds"
        default: return "no-image"
        }
    }
    
    // MARK: - PRIVATE
    
    // MARK: Properties - PRIVATE
    
    private let networkManager: NetworkManagerProtocol
    private var urlComponents: UrlComponentsProtocol
    
    // MARK: Methods - PRIVATE
    
    private func getWeatherURL(cityId: String) -> URL? {

        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: cityId),
            URLQueryItem(name: "appid", value: "2c0724a7707cee690f3818f2bb142711"),
            URLQueryItem(name: "units", value: "metric")
        ]
        return urlComponents.url
    }
}


