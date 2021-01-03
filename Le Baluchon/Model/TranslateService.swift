//
//  TranslateService.swift
//  Le Baluchon
//
//  Created by Saddam Satouyev on 06/12/2020.
//

import Foundation

class TranslateService {
    
    // MARK: - Internal
    
    // MARK: Methods - Internal
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        urlComponents: UrlComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.urlComponents = urlComponents
    }
    
    func translateText(
        sourceLanguage: Language,
        targetLanguage: Language,
        textToTranslate: String,
        completion: @escaping (Result<TranslateResponse, NetworkManagerError>) -> Void)
    {
        guard let url = getTranslateUrl(
            sourcelanguageCode: sourceLanguage.code,
            targetLanguageCode: targetLanguage.code,
            textToTranslate: textToTranslate
        ) else {
            completion(.failure(.couldNotCreateUrl))
            return
        }
        networkManager.fetch(url: url, completion: completion)
    }
    
    // MARK: - PRIVATE
    
    // MARK: Properties - PRIVATE
    
    private var urlComponents: UrlComponentsProtocol
    private let networkManager: NetworkManagerProtocol
    
    // MARK: Methods - PRIVATE
    
    private func getTranslateUrl(sourcelanguageCode: String, targetLanguageCode: String, textToTranslate: String) -> URL? {
        
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
