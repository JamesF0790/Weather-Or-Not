
import UIKit

class TimeTableViewController: UITableViewController {

    var city: City?
    var forecast: Forecast?
    let forecastController = ForecastController()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = city!.name
        tableView.separatorStyle = .none
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let city = city else {fatalError("Whoops")}
        
        switch segue.identifier {
        case "Current":
            let vc = segue.destination as! CurrentForecastTableViewController
            vc.city = city
        case "24Hour":
            let vc = segue.destination as! DayForecastTableViewController
            vc.city = city
        case "7Day":
            let vc = segue.destination as! SevenDayTableViewController
            vc.city = city
        default:
            break
        }
    }
    @IBAction func unwindToTimeVC(segue: UIStoryboardSegue) {
        
    }
}
