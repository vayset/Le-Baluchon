//
//  TranslateServiceTests.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 24/12/2020.
//

import XCTest
@testable import Le_Baluchon

class TranslateServiceTests: XCTestCase {
    
    
    func testGivenTranslateServiceWhenURLComponentsFailedThenCouldNotCreateUrl() {
        
        let translateService = TranslateService(
            urlComponents: UrlComponentsMock()
        )
        
        
        translateService.translateText(
            sourceLanguage: .french,
            targetLanguage: .english,
            textToTranslate: "Bonjour"
        )  { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateUrl)
            case .success:
                XCTFail()
                
            }
        }
        
    }
    
    
    func testGivenTranslateServiceWhenAddTextThenReturnTranslatedText() {
        
        
        let networkManagerMockSucces = NetworkManagerTranslateMock()
        
        let translateService = TranslateService(networkManager: networkManagerMockSucces)
        
        
        translateService.translateText(
            sourceLanguage: .french,
            targetLanguage: .english,
            textToTranslate: "Bonjour"
        )  { (result) in
            switch result {
            case .failure:
                XCTFail()
                
            case .success(let translatedText):
                XCTAssertEqual(translatedText.data!.translations!.first!.translatedText, "Good Morning")
                
            }
        }
        
    }
    
    
    
}
