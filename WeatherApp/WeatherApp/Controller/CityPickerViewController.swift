//
//  CityPickerViewController.swift
//  WeatherApp
//
//  Created by Admin on 04.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit

class CityPickerViewController: UITableViewController {

    var cities:[String]!
    
    var selectedCity:String? = nil
    var selectedCityIndex:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = ["Moscow", "St. Petersburg", "Vladivostok", "Volgograd", "Voronezh", "Yekaterinburg", "Kaliningrad", "Kazan'", "Krasnodar", "Novosibirsk", "Omsk", "Rostov-na-Donu", "Samara", "Yaroslavl'", "Chelyabinsk"]
        if let city = selectedCity {
            selectedCityIndex = cities.index(of: city)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        
        if indexPath.row == selectedCityIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let index = selectedCityIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedCityIndex = indexPath.row
        selectedCity = cities[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedCity" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                selectedCityIndex = indexPath?.row
                if let index = selectedCityIndex {
                    selectedCity = cities[index]
                }
            }
        }
    }
    


}
