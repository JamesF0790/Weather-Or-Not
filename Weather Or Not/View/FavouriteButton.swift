//
//  FavouriteButton.swift
//  Weather Or Not
//
//  Created by James Frost on 26/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class FavouriteButton: UIButton {
    let forecastController = ForecastController()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.blue.cgColor
    }
    func tapped(city: City, currentFavourite: FavouriteForecast?, forecastType: String) {
        let newFavourite = FavouriteForecast(active: true, city: city, forecast: forecastType)
        guard var favourite = currentFavourite else {
            FavouriteForecast.saveFavourite(newFavourite)
            updateColor(newFavourite)
            return
        }
        if favourite == newFavourite {
            favourite.active = !favourite.active
        } else {
            favourite = newFavourite
        }
        updateColor(favourite)
        FavouriteForecast.saveFavourite(favourite)
    }
    func green(){
        self.backgroundColor = .green
        self.setTitleColor(.white, for: .normal)
        self.setTitle("Favourite", for: .normal)
    }
    func red(){
        self.backgroundColor = .red
        self.setTitleColor(.white, for: .normal)
        self.setTitle("UnFavourite", for: .normal)
    }
    
    func updateColor(_ favourite: FavouriteForecast?) {
        guard let favourite = favourite else {green(); return}
        if favourite == FavouriteForecast.loadFavourite() && favourite.active {
            red()
        } else {
            green()
        }

    }
    
}
