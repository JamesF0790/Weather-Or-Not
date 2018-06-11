import UIKit

struct Forecast {
    let current: CurrentForecast
    let daily: DailyForecasts
    
//    enum Keys: String, CodingKey {
//        case current = "currently"
//        case daily
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Keys.self)
//        
//        self.current = try container.decode(CurrentForecast.self, forKey: Keys.current)
//        self.daily = try container.decode(DailyForecasts.self, forKey: Keys.daily)
//    }
}
struct CurrentForecast: Codable {
    let temp: String
    let summary: String
    let icon: String
    let windBearing: String
    let windSpeed: String
    
    init?(json: [String: Any]) {
        guard let temp = json["temperature"] as? String,
            let summary = json["summary"] as? String,
            let icon = json["icon"] as? String,
            let windSpeed = json["windSpeed"] as? String else {return nil}
        self.temp = temp
        self.summary = summary
        self.icon = icon
        self.windSpeed = windSpeed
        if let windBearing = json["windBearing"] as? String{
            self.windBearing = windBearing
        } else {
            self.windBearing = "0"
        }
    }
//    enum Keys: String, CodingKey {
//        case temp = "temperature"
//        case summary
//        case icon
//        case windBearing
//        case windSpeed
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Keys.self)
//
//        self.temp = try container.decode(String.self, forKey: Keys.temp)
//        self.summary = try container.decode(String.self, forKey: Keys.summary)
//        self.icon = try container.decode(String.self, forKey: Keys.icon)
//        self.windSpeed = try container.decode(String.self, forKey: Keys.windSpeed)
//        if let bearing = try? container.decode(String?.self, forKey: Keys.windBearing) {
//            self.windBearing = bearing!
//        } else {
//            self.windBearing = "0"
//        }
//    }
}
struct DailyForecasts: Codable{
    let summary: String
    let icon: String
    let data: [DailyForecast]
    

    init?(json: [String:Any]) {
        
        guard let summary = json["summary"] as? String,
            let icon = json["icon"] as? String,
            let data = json["data"] as? [DailyForecast] else {return nil}
        self.summary = summary
        self.icon = icon
        self.data = data
    }
//    enum Keys: String, CodingKey {
//        case summary
//        case icon
//        case data
//    }
//    init (from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Keys.self)
//
//        self.summary = try container.decode(String.self, forKey: Keys.summary)
//        self.icon = try container.decode(String.self, forKey: Keys.icon)
//        self.data = try container.decode(Array<DailyForecast>.self, forKey: Keys.data)
//    }
}
struct DailyForecast: Codable {
    let date: Date
    let currentTemp: String
    let summary: String
    let highTemp: String
    let lowTemp: String
    let windBearing: String
    let windSpeed: String
    let icon: String
    
    init?(json: [String: Any]) {
        
        guard let date = json["time"] as? Date,
            let currentTemp = json["temperature"] as? String,
            let summary = json["summary"] as? String,
            let highTemp = json["temperatureHigh"] as? String,
            let lowTemp = json["temperatureLow"] as? String,
            let windSpeed = json["windSpeed"] as? String,
            let icon = json["icon"] as? String else {return nil}
        self.date = date
        self.currentTemp = currentTemp
        self.summary = summary
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.windSpeed = windSpeed
        self.icon = icon
        
        if let windBearing = json["windBearing"] as? String {
            self.windBearing = windBearing
        } else {
            self.windBearing = "0"
        }
    }
//    enum Keys: String, CodingKey {
//        case date = "time"
//        case currentTemp = "temperature"
//        case summary
//        case highTemp = "temperatureHigh"
//        case lowTemp = "temperatureLow"
//        case windBearing
//        case windSpeed
//        case icon
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Keys.self)
//
//        self.date = try container.decode(Date.self, forKey: Keys.date)
//        self.currentTemp = try container.decode(String.self, forKey: Keys.currentTemp)
//        self.summary = try container.decode(String.self, forKey: Keys.summary)
//        self.highTemp = try container.decode(String.self, forKey: Keys.highTemp)
//        self.lowTemp = try container.decode(String.self, forKey: Keys.lowTemp)
//        self.windSpeed = try container.decode(String.self, forKey: Keys.windSpeed)
//        self.icon = try container.decode(String.self, forKey: Keys.icon)
//
//        if let bearing = try container.decode(String?.self, forKey: Keys.windBearing) {
//            self.windBearing = bearing
//        } else {
//            self.windBearing = "0"
//        }
//    }
}
