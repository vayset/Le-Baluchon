import XCTest
@testable import Le_Baluchon

class WeatherServiceTests: XCTestCase {

    
    func testWeatherServiceSuccess() {
        
        
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
    
    
    
    
    func testWeatherServiceFailure() {
        
        
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
    
    
    func testWeatherServiceFailureCouldNotCreateUrl() {
        
      
        
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
    
    
    func testWeatherServiceGetImage() {
        
      
        
        let weatherService = WeatherService()
        
        
        XCTAssertEqual(weatherService.getImageId(iconId: 1), "no-image")
        XCTAssertEqual(weatherService.getImageId(iconId: 200), "thunderstorm")
        
    }
    

}
