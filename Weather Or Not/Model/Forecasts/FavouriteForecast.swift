//
//  FavouriteForecast.swift
//  Weather Or Not
//
//  Created by James Frost on 28/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import Foundation

struct FavouriteForecast: Codable {
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

extension FavouriteForecast: Equatable {
    static func == (lhs: FavouriteForecast, rhs: FavouriteForecast) -> Bool {
        return lhs.city == rhs.city && lhs.forecast == rhs.forecast
    }
    static func != (lhs: FavouriteForecast, rhs: FavouriteForecast) -> Bool {
        return lhs.city != rhs.city && lhs.forecast != rhs.forecast
    }
}
