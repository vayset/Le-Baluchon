import XCTest
@testable import Le_Baluchon

class WeatherServiceTests: XCTestCase {
    
    
    func testGivenWeatherServiceWhenNetworkManagerMockSuccessWithWeatherThenWeatherServiceSuccess() {
        
        
        let networkManagerMockSucces = NetworkManagerMockSuccessWithWeather()
        
        let weatherService = WeatherService(networkManager: networkManagerMockSucces)
        
        
        weatherService.getWeather(cityId: "asdasjd") { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let weatherResponse):
                XCTAssertEqual(weatherResponse.name, "Strasbourg")
                XCTAssertEqual(weatherResponse.main!.temp!, 2.2)
            }
        }
        
    }
    
    
    func testGivenWeatherServiceWhenNetworkManagerMockFailureThenWeatherServiceFailure() {
        
        
        let networkManagerMockFailure = NetworkManagerMockFailure()
        
        let weatherService = WeatherService(networkManager: networkManagerMockFailure)
        
        
        weatherService.getWeather(cityId: "asdasjd") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateUrl)
            case .success:
                XCTFail()
                
            }
        }
        
    }
    
    
    func testGivenWeatherServiceWhenURLComponentsFailureThenCouldNotCreateUrl() {
        
        let weatherService = WeatherService(
            urlComponents: UrlComponentsMock()
        )
        
        
        weatherService.getWeather(cityId: "asdasjd") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateUrl)
            case .success:
                XCTFail()
                
            }
        }
        
    }
    
    
    func testGivenWeatherServiceWhenWeAddIconIdThenWeGetImage() {
        
        
        
        let weatherService = WeatherService()
        
        
        XCTAssertEqual(weatherService.getImageId(iconId: 200), "thunderstorm")
        XCTAssertEqual(weatherService.getImageId(iconId: 300), "drizzle")
        XCTAssertEqual(weatherService.getImageId(iconId: 500), "rain")
        XCTAssertEqual(weatherService.getImageId(iconId: 600), "snow")
        XCTAssertEqual(weatherService.getImageId(iconId: 701), "atmosphere")
        XCTAssertEqual(weatherService.getImageId(iconId: 800), "clear")
        XCTAssertEqual(weatherService.getImageId(iconId: 801), "clouds")
        XCTAssertEqual(weatherService.getImageId(iconId: 1), "no-image")
        
        
    }
    
    
}
