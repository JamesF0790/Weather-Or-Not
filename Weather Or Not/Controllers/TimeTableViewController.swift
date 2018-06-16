
import UIKit

class TimeTableViewController: UITableViewController {

    var city: City?
    var forecast: Forecast?
    let forecastController = ForecastController()
    var favourite: FavouriteForecast?
    var favouriteSet = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city!.name
        tableView.separatorStyle = .none
        getForecast() // Consider putting this in the segue so you can't accidentaly crash by tapping too fast.
        checkForFavourite()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let city = city, let forecast = forecast else {fatalError("Whoops")}
        let forecastedCity = ForecastedCity(city: city, forecast: forecast)
        if segue.identifier == "Current" {
            let vc = segue.destination as! CurrentForecastTableViewController
            vc.city = forecastedCity
            if favouriteSet {
                //Pass on the favourite here
            }
        } else if segue.identifier == "24Hour" {
            let vc = segue.destination as! DayForecastTableViewController
            vc.city = forecastedCity
            if favouriteSet {
                //Pass on the favourite here
            }
        } else if segue.identifier == "7Day" {
            let vc = segue.destination as! SevenDayTableViewController
            vc.city = forecastedCity
            if favouriteSet {
                //Pass on the favourite here
            }
        }
    }
    

}

extension TimeTableViewController {

    func getForecast() {
        guard let city = city else {fatalError("No City!")}
        let query = [
            "exclude": "minutely,hourly,flags,alerts",
            "units": "si"
        ]
        forecastController.fetchForecast(at: city, matching: query) { (forecast) in
            if let forecast = forecast {
                self.forecast = forecast
            } else {
                print("Unable to laod data")
            }
        }
    }
    func checkForFavourite() {
        if favouriteSet {
            guard let favourite = favourite else {return}
            performSegue(withIdentifier: favourite.forecast, sender: nil)
        }
    }
}
