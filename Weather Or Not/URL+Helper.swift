//
//  URL+Helper.swift
//  Weather Or Not
//
//  Created by James Frost on 10/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap {URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
    
    func withLatLong(at city: City) ->URL? {
        var url = self
        url = url.appendingPathComponent("\(city.latitude),\(city.longitude)")
        return url
    }
}
