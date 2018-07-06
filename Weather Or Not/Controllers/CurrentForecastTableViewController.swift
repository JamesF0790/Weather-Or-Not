
import UIKit

class CurrentForecastTableViewController: UITableViewController {

    //MARK: Properties
    var city: City?
    var favourite: FavouriteForecast?
    let forecastController = ForecastController()
    let favouriteManager = FavouriteManager()
    var forecast: Forecast?
    
    //MARK: IBOutlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var favouriteButton: FavouriteButton!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast()
        favouriteButton = favouriteManager.updateButton(city: city!, forecastType: "Current", button: favouriteButton )
        tableView.separatorStyle = .none
    }

    //MARK IBActions
    
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
        favouriteManager.updateFavourite(city: city!, forecastType: "Current")
        favouriteButton = favouriteManager.updateButton(city: city!, forecastType: "Current", button: sender)
    }

    //MARK: TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//MARK: Helper Funcs
extension CurrentForecastTableViewController {
	 
    func getForecast() {
        guard let city = city else {fatalError()}
        let query = [
            "exclude": "minutely,hourly,flags,alerts",
            "units": "si"
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        forecastController.fetchForecast(at: city, matching: query) { (forecast) in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    self.cityNameLabel.text = city.name
                    self.temperatureLabel.text = String("Temperature: \(forecast.currently.temperature)°c")
                    self.summaryLabel.text = forecast.currently.summary
                    self.bearingLabel.text = "Wind Bearing: \(forecast.currently.windBearing)°"
                    self.speedLabel.text = "Wind Speed: \(forecast.currently.windSpeed)m/s"
                    self.weatherImageView.image = UIImage(named: forecast.currently.icon)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else {
                fatalError()
            }
        }
    }
}
