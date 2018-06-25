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
struct FavouriteForecast: Codable, Equatable {
    
    var active: Bool
    var city: City
    var forecast: String
    
}

extension FavouriteForecast {
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("favourite").appendingPathExtension("plist")
    
    static func saveFavourite(_ favourite: FavouriteForecast) {
        let propertyListEncoder = PropertyListEncoder()
        let codedFavourite = try? propertyListEncoder.encode(favourite)
        try? codedFavourite?.write(to: archiveURL, options: .noFileProtection)
    }
    static func loadFavourite() -> FavouriteForecast? {
        let propertyListDecoder = PropertyListDecoder()
        guard let codedFavourite = try? Data(contentsOf: archiveURL) else {return nil}
        return try? propertyListDecoder.decode(FavouriteForecast.self, from: codedFavourite)
    }
}

extension FavouriteForecast {
    static func == (lhs: FavouriteForecast, rhs: FavouriteForecast) -> Bool {
        return lhs.city == rhs.city && lhs.forecast == rhs.forecast
    }
    static func != (lhs: FavouriteForecast, rhs: FavouriteForecast) -> Bool {
        return lhs.city != rhs.city && lhs.forecast != rhs.forecast
    }
}
