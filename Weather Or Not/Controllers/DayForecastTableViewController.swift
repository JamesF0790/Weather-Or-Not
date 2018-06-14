
import UIKit

class DayForecastTableViewController: UITableViewController {

    var city: ForecastedCity?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageLabel: UIImageView!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city else {return}
        updateUI(city: city)
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

extension DayForecastTableViewController {
    func updateUI(city: ForecastedCity) {
        let forecast = city.forecast.daily.data[0], city = city.city
        let date = NSDate(timeIntervalSince1970: forecast.time)
        DispatchQueue.main.async {
            self.cityNameLabel.text = city.name
            self.dateLabel.text = DailyForecast.dateFormatter.string(from: date as Date)
            self.weatherImageLabel.image = UIImage(named: forecast.icon)
            self.highTemperatureLabel.text = "High:\(forecast.temperatureHigh)°c"
            self.lowTemperatureLabel.text = "Low:\(forecast.temperatureLow)°c"
            self.windBearingLabel.text = "Wind Bearing:\(forecast.windBearing)°"
            self.windSpeedLabel.text = "Wind Speed:\(forecast.windSpeed)m/s"
        }
    }
}
