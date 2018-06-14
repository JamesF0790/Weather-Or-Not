
import Foundation

struct City: Comparable {
    let name: String
    let latitude: Double
    let longitude: Double

    
    static func < (lhs: City, rhs: City) -> Bool {
        return lhs.name < rhs.name
    }
}

extension City {
    static func loadCities() -> [City] {
        let cities: [City] = [
            City(name: "New York", latitude: 40.7128, longitude: -74.0060),
            City(name: "London", latitude: 51.5074, longitude: -0.1278),
            City(name: "Sydney", latitude: -33.8651, longitude: 151.2099),
            City(name: "Tokyo", latitude: 35.6894, longitude: 139.6917),
            City(name: "Madrid", latitude: 40.4167, longitude: -3.7037),
            City(name: "Pyongyang", latitude: 39.0389, longitude: 125.7643),
            City(name: "Jerusalem", latitude: 31.7683, longitude: 35.2137),
            City(name: "Ottowa", latitude: 45.4215, longitude: -75.6971),
            City(name: "Mexico City", latitude: 19.4326, longitude: -99.1332),
            City(name: "Aukland", latitude: -36.8484, longitude: 174.7633),
            City(name: "Beijing", latitude: 39.9042, longitude: 116.407396),
            City(name: "Honolulu", latitude: 21.3069, longitude: -157.8583),
            City(name: "Washington DC", latitude: 38.9071, longitude: -77.0368),
            City(name: "Berlin", latitude: 52.5200, longitude: 13.4049),
            City(name: "Melbourne", latitude: -37.8136, longitude: 144.9630),
            City(name: "Miami", latitude: 25.7616, longitude: -80.1917),
            City(name: "Dallas", latitude: 32.7766, longitude: -96.7969),
            City(name: "Vienna", latitude: 48.2081, longitude: 16.3738),
            City(name: "Canberra", latitude: -35.2809, longitude: 149.1300),
            City(name: "Baghdad", latitude: 33.3128, longitude: 44.3614)
        ]
        let sortedCities = cities.sorted(by: <)
        return sortedCities
    }
}

struct ForecastedCity {
    let city: City
    let forecast: Forecast
}
