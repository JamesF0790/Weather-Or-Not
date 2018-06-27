//
//  DailyForecasts.swift
//  Weather Or Not
//
//  Created by James Frost on 28/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import Foundation

struct DailyForecasts: Codable{
    let summary: String
    let icon: String
    let data: [DailyForecast]
    
}
