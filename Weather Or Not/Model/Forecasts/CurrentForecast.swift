//
//  CurrentForecast.swift
//  Weather Or Not
//
//  Created by James Frost on 28/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import Foundation

struct CurrentForecast: Codable {
    let temperature: Double
    let summary: String
    let icon: String
    let windBearing: Int
    let windSpeed: Double
}
