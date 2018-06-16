

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
            performSegue(withIdentifier: "Favourite", sender: nil)
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TimeTableViewController
        let indexPath = tableView.indexPathForSelectedRow
        let city = cities[(indexPath?.row)!]
        vc.city = city
        
        if segue.identifier == "Favourite" { // Consider replacing with boolean check before submitting
            vc.favourite = favourite
            vc.favouriteSet = true
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
