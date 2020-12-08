//
//  Language.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 06/12/2020.
//

import Foundation

enum Language {
    case english
    case french
    
    var code: String {
        switch self {
        case .english: return "en"
        case .french: return "fr"
        }
    }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .french: return "French"
        }
    }
}
