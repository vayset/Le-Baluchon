//
//  Value.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 05/12/2020.
//

import Foundation

enum Currency {
    case euro
    case usd
    
    var code: String {
        switch self {
        case .euro: return "EUR"
        case .usd: return "USD"
        }
        
    }
    
    var displayIcons: String {
        switch self {
        case .euro: return "euro"
        case .usd: return "usd"
        }
    }
    
}
