
import UIKit

class DayForecastTableViewController: UITableViewController {

    var city: City?
    var favourite: FavouriteForecast?
    let forecastController = ForecastController()
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageLabel: UIImageView!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DayForecastTableViewController {

    func getForecast() {
        guard let city = city else {fatalError("No city")}
        let query = [
            "exclude": "minutely,hourly,flags,alerts:",
            "units": "si"
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        forecastController.fetchForecast(at: city, matching: query) { (forecast) in
            if let forecast = forecast?.daily.data[0] {
                DispatchQueue.main.async {
                    self.cityNameLabel.text = city.name
                    self.dateLabel.text = forecast.stringTime
                    self.weatherImageLabel.image = UIImage(named: forecast.icon)
                    self.highTemperatureLabel.text = "High:\(forecast.temperatureHigh)°c"
                    self.lowTemperatureLabel.text = "Low:\(forecast.temperatureLow)°c"
                    self.windBearingLabel.text = "Wind Bearing:\(forecast.windBearing)°"
                    self.windSpeedLabel.text = "Wind Speed:\(forecast.windSpeed)m/s"
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
            }
        }
        
    }
}
