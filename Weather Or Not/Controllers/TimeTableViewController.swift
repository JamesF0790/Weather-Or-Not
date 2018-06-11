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
        getForecast()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Current" {
            let vc = segue.destination as! CurrentForecastTableViewController
            let forecastedCity = ForecastedCity(city: city!, forecast: forecast!)
            vc.city = forecastedCity
        }
    }
    

}

extension TimeTableViewController {
    func getForecast() {
        let query = [
            "exclude": "minutely,hourly,flags,alerts"
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
