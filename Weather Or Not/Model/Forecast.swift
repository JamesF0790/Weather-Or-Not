import UIKit

struct Forecast: Codable {
    let currently: CurrentForecast
    let daily: DailyForecasts
    
}
struct CurrentForecast: Codable {
    let temperature: Double
    let summary: String
    let icon: String
    let windBearing: Int
    let windSpeed: Double
    
}
struct DailyForecasts: Codable{
    let summary: String
    let icon: String
    let data: [DailyForecast]

}
struct DailyForecast: Codable {
    let time: Double
    let summary: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let windBearing: Int
    let windSpeed: Double
    let icon: String
}

extension DailyForecast {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

}
