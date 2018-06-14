//
//  TimeTableViewController.swift
//  Weather Or Not
//
//  Created by James Frost on 11/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class TimeTableViewController: UITableViewController {

    var city: City?
    var forecast: Forecast?
    let forecastController = ForecastController()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city!.name
        getForecast()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let city = city, let forecast = forecast else {fatalError("Whoops")}
        let forecastedCity = ForecastedCity(city: city, forecast: forecast)
        if segue.identifier == "Current" {
            let vc = segue.destination as! CurrentForecastTableViewController
            vc.city = forecastedCity
        } else if segue.identifier == "24Hour" {
            let vc = segue.destination as! DayForecastTableViewController
            vc.city = forecastedCity
        } else if segue.identifier == "7Day" {
            let vc = segue.destination as! WeekForecastTableViewController
            vc.city = forecastedCity
        }
    }
    

}

extension TimeTableViewController {
    func getForecast() {
        let query = [
            "exclude": "minutely,hourly,flags,alerts",
            "units": "si"
        ]
        forecastController.fetchForecast(at: city!, matching: query) { (forecast) in
            DispatchQueue.main.async {
                if let forecast = forecast {
                    self.forecast = forecast
                } else {
                    print ("Unable to load data")
                }
            }
        }
    }
}
