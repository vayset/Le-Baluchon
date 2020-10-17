import Foundation

// MARK: - CurrencyResponse
struct WeatherResponse: Codable {
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
    }
}
