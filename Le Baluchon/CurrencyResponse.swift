//
//  CurrencyResponse.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 11/10/2020.
//

import Foundation


// MARK: - CurrencyResponse
struct CurrencyResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
