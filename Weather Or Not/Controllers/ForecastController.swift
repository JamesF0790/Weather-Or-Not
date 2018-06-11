//
//  ForecastController.swift
//  Weather Or Not
//
//  Created by James Frost on 11/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import Foundation

struct ForecastController {
    
    func fetchForecast (at city: City, matching query: [String: String], completion: @escaping (Forecast?) -> Void) {
        
        let baseURL = URL(string: "https://api.darksky.net/forecast/cf9f199e3fc7f52e7eccbd021e4e71b3/")
        
        guard let cityURL = baseURL?.withLatLong(at: city) else {
            completion(nil)
            print("Could not set city")
            return
        }
        print (cityURL)
        guard let url = cityURL.withQueries(query) else {
            completion (nil)
            print ("Could not set queries")
            return
        }

        print (url)
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            let decoder = JSONDecoder()
//
//            if let data = data, let forecast = try? decoder.decode(Forecast.self, from: data) {
//                completion (forecast)
//
//            } else {
//                print ("Could not retrieve forecast, either not data was returned or data was not serialized")
//                completion (nil)
//                return
//            }
//        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [String: Any],
                let currentArray = json["currently"] as? [String: Any],
                let dailyArray = json["daily"] as? [String: Any],
                let dailyArrays = dailyArray["data"] as? [String: Any]
                {
                    let currentForecast = CurrentForecast(json: currentArray)!
                    let dailyForecast = DailyForecasts(json: dailyArray)!
                    let forecast = Forecast(current: currentForecast, daily: dailyForecast)
                    completion(forecast)
                    
            } else {
                print ("Could not retrieve forecast")
                completion (nil)
                return
            }
        }
        
        task.resume()
    }
}
