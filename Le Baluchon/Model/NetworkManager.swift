//
//  NetworkManager.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 12/11/2020.
//

import Foundation

class NetworkManager {
    
     func getWeatherURL(cityId: String) -> URL? {
        
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

    func getTranslateUrl(sourcelanguageCode: String, targetLanguageCode: String, textToTranslate: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "AIzaSyCvWsHARdQkJ2LkskI6fP-xcOQM_Bc-yC0"),
            URLQueryItem(name: "q", value: textToTranslate),
            URLQueryItem(name: "source", value: sourcelanguageCode),
            URLQueryItem(name: "target", value: targetLanguageCode),
            URLQueryItem(name: "format", value: "text")
        ]
        
        return urlComponents.url
    }
    
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)  {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidHttpStatusCode))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let decoddedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecodeJSON))
                return
            }
            
            completion(.success(decoddedData))
            return
        }
        
        task.resume()
    }
    
}
