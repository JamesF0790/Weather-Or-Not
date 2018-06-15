//
//  SevenDayTableViewController.swift
//  Weather Or Not
//
//  Created by James Frost on 15/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class SevenDayTableViewController: UITableViewController {

    var city: ForecastedCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let forecast = city?.forecast.daily else {fatalError("could not set forecast")}
        return forecast.data.count - 1
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "weekly") as! WeeklySummaryTableViewCell
        guard let forecast = city?.forecast.daily, let city = city?.city else {fatalError("Could not set up weekly Summary")}
        DispatchQueue.main.async {
            headerCell.cityLabel.text = city.name
            headerCell.weatherImage.image = UIImage(named: forecast.icon)
            headerCell.weatherLabel.text = forecast.summary
            headerCell.backgroundColor = .white
        }
        
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daily", for: indexPath) as! DailyTableViewCell
        guard let forecast = city?.forecast.daily.data[indexPath.row] else {fatalError("Could not set up daily cell")}
        let date = NSDate(timeIntervalSince1970: forecast.time)
        
        DispatchQueue.main.async {
            cell.dateLabel.text = DailyForecast.dateFormatter.string(from: date as Date)
            cell.summaryLabel.text = forecast.summary
            cell.weatherImage.image = UIImage(named: forecast.icon)
            cell.highTemperatureLabel.text = "High: \(forecast.temperatureHigh)"
            cell.lowTemperatureLabel.text = "Low: \(forecast.temperatureLow)"
            cell.windBearingLabel.text = "Wind Bearing: \(forecast.windBearing)"
            cell.windSpeedLabel.text = "Wind Speed: \(forecast.windSpeed)"
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
