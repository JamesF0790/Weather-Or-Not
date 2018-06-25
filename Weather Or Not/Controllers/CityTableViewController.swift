

import UIKit

class CityTableViewController: UITableViewController {

    var firstDisplay = true
    var cities = [City]()
    var favourite: FavouriteForecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = City.loadCities()
        checkForFavourite()
        if favourite != nil {
            if favourite?.active == true {
                performSegue(withIdentifier: favourite!.forecast, sender: nil)
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)

        cell.textLabel?.text = cities[indexPath.row].name

        return cell
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Current":
            let vc = segue.destination as! CurrentForecastTableViewController
            vc.city = favourite!.city
            
            vc.favourite = favourite
        case "24Hour":
            let vc = segue.destination as! DayForecastTableViewController
            vc.city = favourite!.city
            
            vc.favourite = favourite
        case "7Day":
            let vc = segue.destination as! SevenDayTableViewController
            vc.city = favourite!.city
            
            vc.favourite = favourite
        default:
            let vc = segue.destination as! TimeTableViewController
            vc.city = cities[(tableView.indexPathForSelectedRow?.row)!]
            
        }

    }
    
}

extension CityTableViewController {
    func checkForFavourite() {
        guard let savedFave = FavouriteForecast.loadFavourite() else {return}
        favourite = savedFave
        guard firstDisplay == true && favourite!.active == true else {return}
        firstDisplay = false
    }
}
