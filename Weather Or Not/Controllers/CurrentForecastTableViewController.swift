//
//  CurrentForecastTableViewController.swift
//  Weather Or Not
//
//  Created by James Frost on 11/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class CurrentForecastTableViewController: UITableViewController {

    var city: ForecastedCity?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        tableView.separatorStyle = .none
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrentForecastTableViewController {
    func updateUI() {
        cityNameLabel.text = city!.city.name
        temperatureLabel.text = "\(city!.forecast.currently.temperature)°c"
        summaryLabel.text = city!.forecast.currently.summary
        bearingLabel.text = "\(city!.forecast.currently.windBearing)°"
        speedLabel.text = "\(city!.forecast.currently.windSpeed)m/s"
        weatherImageView.image = UIImage(named: city!.forecast.currently.icon)
    }
}
