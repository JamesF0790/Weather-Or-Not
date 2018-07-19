
import Foundation

struct ForecastManager {
    
    func fetchForecast (at city: City, matching query: [String: String], completion: @escaping (Forecast?) -> Void) {
        
        let baseURL = URL(string: "https://api.darksky.net/forecast/cf9f199e3fc7f52e7eccbd021e4e71b3/")
        
        guard let cityURL = baseURL?.withLatLong(at: city) else {
            completion(nil)
            print("Could not set city")
            return
        }
        
        guard let url = cityURL.withQueries(query) else {
            completion (nil)
            print ("Could not set queries")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data, let forecast = try? decoder.decode(Forecast.self, from: data) {
                completion(forecast)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
