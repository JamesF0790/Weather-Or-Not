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
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let forecast = try? decoder.decode(Forecast.self, from: data)
            let string = String(data: data, encoding: .utf8)
            print (data)
            print (string)
            print (forecast)

        }

        task.resume()
    }
}
