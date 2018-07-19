
import UIKit

class DayForecastTableViewController: UITableViewController {

    var city: City?
    var favourite: FavouriteForecast?
    let forecastManager = ForecastManager()
    let favouriteManager = FavouriteManager()
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var weatherImageLabel: UIImageView!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getForecast()
        tableView.separatorStyle = .none
        favouriteButton = favouriteManager.updateButton(city: city!, forecastType: "24Hour", button: favouriteButton)
    }

    @IBAction func favouriteButtonTapped(_ sender: FavouriteButton) {
        UIView.animate(withDuration: 0.05, animations: {
            
            let rotationTransform = CGAffineTransform(rotationAngle: 0.05)
            
            sender.transform = rotationTransform
        }) { (_) in
            UIView.animate(withDuration: 0.05, animations: {
                let rotationTransform = CGAffineTransform(rotationAngle: -0.10)
                
                sender.transform = rotationTransform
            }, completion: { (_) in
                UIView.animate(withDuration: 0.05, animations: {
                    sender.transform = CGAffineTransform.identity
                })
            })
        }
        favouriteManager.updateFavourite(city: city!, forecastType: "24Hour")
        favouriteButton = favouriteManager.updateButton(city: city!, forecastType: "24Hour", button: sender)
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
        forecastManager.fetchForecast(at: city, matching: query) { (forecast) in
            if let forecast = forecast?.daily.data[0] {
                DispatchQueue.main.async {
                    self.cityNameLabel.text = city.name
                    self.dateLabel.text = forecast.stringTime
                    self.summaryLabel.text = forecast.summary
                    self.weatherImageLabel.image = UIImage(named: forecast.icon)
                    self.highTemperatureLabel.text = "High:\(forecast.temperatureHigh)°c"
                    self.lowTemperatureLabel.text = "Low:\(forecast.temperatureLow)°c"
                    self.windBearingLabel.text = "Wind Bearing:\(forecast.windBearing)°"
                    self.windSpeedLabel.text = "Wind Speed:\(forecast.windSpeed)m/s"
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else if forecast == nil {
                let alertController = UIAlertController(title: "Could not fetch forecast", message: "An error has occured and the forecast could not be fetched. Please try again", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Okay", style: .default, handler: { (_) in
                    self.performSegue(withIdentifier: "timeUnwind", sender: self)
                })
                
                alertController.addAction(okAction)
                alertController.popoverPresentationController?.sourceView = self.cityNameLabel
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
}
