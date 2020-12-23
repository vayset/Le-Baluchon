//
//  NetworkManagerWeatherMock.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 20/12/2020.
//

import Foundation

@testable import Le_Baluchon

class NetworkManagerMockSuccessWithWeather: NetworkManagerProtocol {
   
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        
        let weatherResponse = WeatherResponse(
            weather: [
                Weather(id: 203, main: "")
            ],
            main: Main(temp: 2.2),
            name: "Strasbourg"
        )
        
        completion(.success(weatherResponse as! T))

    }
    
    
}
