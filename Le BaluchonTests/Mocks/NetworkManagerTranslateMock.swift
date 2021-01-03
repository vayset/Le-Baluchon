//
//  NetworkManagerMockTranslate.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 24/12/2020.
//

import Foundation
@testable import Le_Baluchon

class NetworkManagerTranslateMock: NetworkManagerProtocol {

    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        
        let translateResponse = TranslateResponse(
            data: DataClass(
                translations: [
                    Translation(translatedText: "Good Morning")
                ]
            )
        )
    
        
        completion(.success(translateResponse as! T))
    }
}
