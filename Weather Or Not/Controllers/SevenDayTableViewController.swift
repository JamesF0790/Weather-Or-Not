//
//  SevenDayTableViewController.swift
//  Weather Or Not
//
//  Created by James Frost on 15/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class SevenDayTableViewController: UITableViewController {

    var city: City?
    var favourite: FavouriteForecast?
    var forecast: Forecast?
    let forecastController = ForecastController()
    override func viewDidLoad() {
        super.viewDidLoad()
        getforecast()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "weekly") as! WeeklySummaryTableViewCell
        headerCell.backgroundColor = .white

        if let forecast = forecast?.daily, let city = city {
            DispatchQueue.main.async {
                headerCell.cityLabel.text = city.name
                headerCell.weatherImage.image = UIImage(named: forecast.icon)
                headerCell.weatherLabel.text = forecast.summary
            }
        } else {
            headerCell.cityLabel.text = "Loading"
            headerCell.weatherImage.image = nil
            headerCell.weatherLabel.text = "Loading"
        }
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daily", for: indexPath) as! DailyTableViewCell
        if let forecast = forecast?.daily.data[indexPath.row] {
            DispatchQueue.main.async {
                cell.dateLabel.text = forecast.stringTime
                cell.summaryLabel.text = forecast.summary
                cell.weatherImage.image = UIImage(named: forecast.icon)
                cell.highTemperatureLabel.text = "High: \(forecast.temperatureHigh)"
                cell.lowTemperatureLabel.text = "Low: \(forecast.temperatureLow)"
                cell.windBearingLabel.text = "Wind Bearing: \(forecast.windBearing)"
                cell.windSpeedLabel.text = "Wind Speed: \(forecast.windSpeed)"
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        } else {
            cell.dateLabel.text = "Loading"
            cell.summaryLabel.text = "Loading"
            cell.weatherImage.image = nil
            cell.highTemperatureLabel.text = "Loading"
            cell.lowTemperatureLabel.text = "Loading"
            cell.windBearingLabel.text = "Loading"
            cell.windSpeedLabel.text = "Loading"
        }

        return cell
    }
    func getforecast() {
        guard let city = city else {fatalError("No City")}
        let query = [
            "exclude": "minutely,hourly,flags,alerts",
            "units": "si"
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        forecastController.fetchForecast(at: city, matching: query) { (forecast) in
            self.forecast = forecast
        }
        tableView.reloadData()
    }

}
