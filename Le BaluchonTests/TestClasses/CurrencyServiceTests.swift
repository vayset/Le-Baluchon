import XCTest
@testable import Le_Baluchon

class CurrencyServiceTests: XCTestCase {
    
    func testGivenCurrencyServiceWhenAddNumberThenCurrencyServiceSuccess() {
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
    
    func testGivenCurrencyServiceWhenAddDoubleNumberThenCurrencyServiceSuccess() {
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
    
    
    
    func testGivenCurrencyServiceWhenNetworkManagerFailureThenCurrencyServiceFaillure() {
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
    
    
    func testGivenCurrencyServiceWhenGetRateFailedThenCouldNotGetRatesFromResponse() {
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
}






