import UIKit

struct Forecast: Codable {
//    let currently: CurrentForecast
    let daily: DailyForecasts
    
}
struct CurrentForecast: Codable {
    let temperature: String
    let summary: String
    let icon: String
    let windBearing: String
    let windSpeed: String
    
}
struct DailyForecasts: Codable{
    let summary: String
    let icon: String
//    let data: [DailyForecast]

}
struct DailyForecast: Codable {
    let time: Double
    let summary: String
    let temperatureHigh: String
    let temperatureLow: String
    let windBearing: String
    let windSpeed: String
    let icon: String

}
