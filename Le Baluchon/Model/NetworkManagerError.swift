//
//  NetworkManagerError.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 12/11/2020.
//

import Foundation


enum NetworkManagerError: LocalizedError {
    case noData
    case failedToDecodeJSON
    case unknownError
    case invalidHttpStatusCode
    case couldNotCreateUrl
    
    var errorDescription: String? {
        switch self {
        case .couldNotCreateUrl: return "Could not create URL"
        case .failedToDecodeJSON: return "Failed to decode json"
        case .invalidHttpStatusCode: return "invalid httpt status code"
        case .noData: return "No data"
        case .unknownError: return "Unknown error occured"
        }
    }
}
