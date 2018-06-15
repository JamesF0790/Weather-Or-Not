
import UIKit

class WeekForecastTableViewController: UITableViewController {

    var city: ForecastedCity?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weeklyWeatherImage: UIImageView!
    @IBOutlet weak var weeklyWeatherSummary: UILabel!
    @IBOutlet weak var day1Date: UILabel!
    @IBOutlet weak var day1Summary: UILabel!
    @IBOutlet weak var day1Image: UIImageView!
    @IBOutlet weak var day1High: UILabel!
    @IBOutlet weak var day1Low: UILabel!
    @IBOutlet weak var day1WindBearing: UILabel!
    @IBOutlet weak var day1WindSpeed: UILabel!
    @IBOutlet weak var day2Date: UILabel!
    @IBOutlet weak var day2Summary: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city else {fatalError("Could not set city")}
        updateUI(city: city)
    }

    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension WeekForecastTableViewController {
    func updateUI(city: ForecastedCity) {
        let forecast = city.forecast, city = city.city
        DispatchQueue.main.async {
            self.cityNameLabel.text = city.name
            self.weeklyWeatherImage.image = UIImage(named: forecast.daily.icon)
            self.weeklyWeatherSummary.text = forecast.daily.summary
        }
    }
}
