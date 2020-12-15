//
//  CurrencyService.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 15/12/2020.
//

import Foundation
class CurrencyService {
    
    func getCurrencyURL() -> URL? {
        
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
