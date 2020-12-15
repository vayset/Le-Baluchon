//
//  CurrencyService.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 15/12/2020.
//

import Foundation


enum CurrencyServiceError: Error {
    case couldNotGetRatesFromResponse
    case networkManagerFailedToProvideRates
}



class CurrencyService {
    
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    
    private let networkManager: NetworkManagerProtocol
    
    func getConvertedValue(
        sourceCurrency: Currency,
        targetCurrency: Currency,
        valueToConvert: Double,
        completion: @escaping (Result<String, CurrencyServiceError>) -> Void
    ) {
        guard let url = getCurrencyURL() else { return }
        networkManager.fetch(url: url) { (result: Result<CurrencyResponse, NetworkManagerError>) in
            switch result {
            case .failure:
                completion(.failure(.networkManagerFailedToProvideRates))
                return
                
            case .success(let response):
                
                guard
                    let sourceRate = response.rates[sourceCurrency.code],
                    let targetRate = response.rates[targetCurrency.code]
                else {
                    completion(.failure(.couldNotGetRatesFromResponse))
                    return
                }
                
                let conversionRate = targetRate / sourceRate
                
                let convertedValue = valueToConvert * conversionRate
  
                let valueFormated = String(format: "%.2f", convertedValue)

                completion(.success(valueFormated))
                return
            }
        }
    }
    
    
    private func getCurrencyURL() -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: "7dc786b7cef348978bc4d5664e536441")
        ]
        
        return urlComponents.url
    }
    
}
