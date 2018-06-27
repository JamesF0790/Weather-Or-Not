//
//  FavouriteManager.swift
//  Weather Or Not
//
//  Created by James Frost on 28/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class FavouriteManager {
    
    func updateFavourite(city: City, forecastType: String) {
        let newFavourite = FavouriteForecast(active: true, city: city, forecast: forecastType)
        guard var favourite = FavouriteForecast.loadFavourite() else {
            FavouriteForecast.saveFavourite(newFavourite)
            return
        }
        if favourite == newFavourite {
            favourite.active = !favourite.active
        } else {
            favourite = newFavourite
        }
        FavouriteForecast.saveFavourite(favourite)
    }
    
    func updateButton(city: City, forecastType: String, button: FavouriteButton) -> FavouriteButton {
        let favourite = FavouriteForecast(active: true, city: city, forecast: forecastType)
        //Set up the button for the first two checks, making it green
        button.backgroundColor = .green
        button.setTitle("Favourite", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        guard let oldFavourite = FavouriteForecast.loadFavourite() else {return button}
        guard oldFavourite == favourite && oldFavourite.active else {return button}
        
        //If the checks passed set it to red and return it
        button.backgroundColor = .red
        button.setTitle("Unfavourite", for: .normal)
        
        return button
    }
}
