//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 06/10/2020.
//

import XCTest
@testable import Le_Baluchon

class Le_BaluchonTests: XCTestCase {

//
//    func testExample() throws {
//        let urlString = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyCvWsHARdQkJ2LkskI6fP-xcOQM_Bc-yC0&q=moi&source=en&target=fr&format=text"
//
//        let translateUrlProvider = TranslateUrlProvider()
//        let urlCreated = translateUrlProvider.getTranslateUrl(textToTranslate: "moi")!
//        XCTAssertEqual(urlString, urlCreated.absoluteString)
//
//    }

    
    
    func testCurrencyServiceSuccess() {
        let networkManagerMockSucces = NetworkManagerMockSuccessWithRate(euroRate: 1, usdRate: 2)
        
        let currencyService = CurrencyService(networkManager: networkManagerMockSucces)
        
        currencyService.getConvertedValue(
            sourceCurrency: .euro,
            targetCurrency: .usd,
            valueToConvert: 10
        ) { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let convertedValue):
                XCTAssertEqual(convertedValue, "20.00")
            }
        }
    }
    
    func testCurrencyServiceSuccessOther() {
        let networkManagerMockSucces = NetworkManagerMockSuccessWithRate(euroRate: 4, usdRate: 20)
        
        let currencyService = CurrencyService(networkManager: networkManagerMockSucces)
        
        currencyService.getConvertedValue(
            sourceCurrency: .euro,
            targetCurrency: .usd,
            valueToConvert: 2.5
        ) { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let convertedValue):
                XCTAssertEqual(convertedValue, "12.50")
            }
        }
    }
    
    
    
    func testCurrencyServiceFailure() {
        let networkManagerMockFail = NetworkManagerMockFailure()
        
        let currencyService = CurrencyService(networkManager: networkManagerMockFail)
        
        currencyService.getConvertedValue(
            sourceCurrency: .euro,
            targetCurrency: .usd,
            valueToConvert: 10
        ) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, CurrencyServiceError.networkManagerFailedToProvideRates)
                
            case .success:
                XCTFail()
            }
        }
    }
    
    
    func testCurrencyServiceFailureRate() {
        let networkManagerMockFailNoRate = NetworkManagerMockNoEuroRate()
        
        let currencyService = CurrencyService(networkManager: networkManagerMockFailNoRate)
        
        currencyService.getConvertedValue(
            sourceCurrency: .euro,
            targetCurrency: .usd,
            valueToConvert: 10
        ) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, CurrencyServiceError.couldNotGetRatesFromResponse)
                
            case .success:
                XCTFail()
            }
        }
    }
    
    
    func testWeatherServiceSuccess()  {
        
        let  networkManagerWeatherMockSucces = NetworkManagerWeatherMockSucces()
        
        _ = WeatherService(networkManager: networkManagerWeatherMockSucces)
        
            
        
    }
    

}
