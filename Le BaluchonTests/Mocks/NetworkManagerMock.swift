//
//  NetworkManagerMock.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 15/12/2020.
//

import Foundation

@testable import Le_Baluchon

// MARK: - tableview delegate methods
class NetworkManagerMockFailure: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        completion(.failure(.couldNotCreateUrl))
    }
}

// Individiual
class NetworkManagerMockSuccessWithRate: NetworkManagerProtocol {
    
    init(euroRate: Double, usdRate: Double) {
        self.euroRate = euroRate
        self.usdRate = usdRate
    }
    
    let euroRate: Double
    let usdRate: Double
    
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        
        let currencyResponse = CurrencyResponse(
            success: true,
            timestamp: 1234,
            base: "EUR",
            date: "1233",
            rates: [
                "EUR": euroRate,
                "USD": usdRate
            ]
        )
        
        completion(.success(currencyResponse as! T))
    }
    
    
}

class NetworkManagerMockNoEuroRate: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        
        let currencyResponse = CurrencyResponse(
            success: true,
            timestamp: 1234,
            base: "EUR",
            date: "1233",
            rates: [
                "CHF": 1,
                "ASD": 2
            ]
        )
        
        completion(.success(currencyResponse as! T))
    }
    
    
}

