//
//  DailyForecast.swift
//  Weather Or Not
//
//  Created by James Frost on 28/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import Foundation

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
    var stringTime: String {
        return TimeFormatter.dateString(fromTimeStamp: self.time)
    }
}
