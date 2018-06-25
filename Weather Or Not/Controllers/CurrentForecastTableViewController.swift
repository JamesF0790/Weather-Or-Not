
import UIKit

class CurrentForecastTableViewController: UITableViewController {

    var city: City?
    var favourite: FavouriteForecast?
    let forecastController = ForecastController()
    var forecast: Forecast?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getForecast()
        checkFavouriteButton()
        tableView.separatorStyle = .none
        favouriteButton.layer.cornerRadius = 5
        favouriteButton.layer.borderWidth = 1
        favouriteButton.layer.borderColor = UIColor.blue.cgColor
    }
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        guard let city = city else {return}
        let newFavourite = FavouriteForecast(active: true, city: city, forecast: "Current")
        if favourite == newFavourite {
            let favouriteState = !(favourite?.active)!
            favourite?.active = favouriteState
        } else {
            favourite = newFavourite
        }

        UIView.animate(withDuration: 0.05, animations: {//Set this up in a seperate class for the button. 
            let rotationTransform = CGAffineTransform(rotationAngle: 0.05)

            sender.transform = rotationTransform
        }) { (_) in
            UIView.animate(withDuration: 0.05, animations: {
                let rotationTransform = CGAffineTransform(rotationAngle: -0.10)
                
                sender.transform = rotationTransform
            }, completion: { (_) in
                sender.transform = CGAffineTransform.identity
            })
        }
        FavouriteForecast.saveFavourite(favourite!)
        checkFavouriteButton()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

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
    func checkFavouriteButton() {
        guard let favourite = favourite else {return}
        if favourite == FavouriteForecast.loadFavourite() {
            if favourite.active {
                favouriteButton.backgroundColor = .red
                favouriteButton.setTitle("Unfavourite", for: .normal)
                favouriteButton.setTitleColor(.white, for: .normal)
            } else {
                favouriteButton.backgroundColor = .green
                favouriteButton.setTitleColor(.blue, for: .normal)
                favouriteButton.setTitle("Favourite", for: .normal)
            }
        } else {
            favouriteButton.backgroundColor = .green
            favouriteButton.setTitleColor(.blue, for: .normal)
            favouriteButton.setTitle("Favourite", for: .normal)
        }
//        if favourite == FavouriteForecast.loadFavourite() && favourite.active {
//            return true
//        } else {
//            return false
//        }
    }
}
