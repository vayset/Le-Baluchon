//
//  TranslateService.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 06/12/2020.
//

import Foundation

class TranslateService {
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
}
