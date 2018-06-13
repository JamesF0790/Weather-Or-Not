//
//  CityTableViewController.swift
//  Weather Or Not
//
//  Created by James Frost on 11/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {

    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = City.loadCities()

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
    }
    

}
