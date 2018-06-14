
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
        guard let city = city else {fatalError("No Forecasted City")}
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

extension CurrentForecastTableViewController {
    func updateUI(city: ForecastedCity) {
        let forecast = city.forecast, city = city.city
        DispatchQueue.main.async {
            self.cityNameLabel.text = city.name
            self.temperatureLabel.text = "Temperature:\(forecast.currently.temperature)°c"
            self.summaryLabel.text = forecast.currently.summary
            self.bearingLabel.text = "Wind Bearing:\(forecast.currently.windBearing)°"
            self.speedLabel.text = "Wind Speed:\(forecast.currently.windSpeed)m/s"
            self.weatherImageView.image = UIImage(named: forecast.currently.icon)
        }
    }
}
