//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 11/10/2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    private let networkManager = NetworkManager()
    
    
    func getWeather() {
        let urlString = "" // utilise l'utl corresponsdante à l'API weather
        let url = URL(string: urlString)!
        networkManager.fetch(url: url, completion: assignWeatherToLabel)
    }
    
    
    func assignWeatherToLabel(currencyResponse: Result<CurrencyResponse, NetworkManagerError>) { // Change currency response

        DispatchQueue.main.async {
            
            switch currencyResponse {
            case .failure(let error):
                print(error.localizedDescription)
                
    
            case .success(let response):
                print("success")
            }
            
        }
        
    }
    
}
