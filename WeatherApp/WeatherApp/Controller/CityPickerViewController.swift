//
//  CityPickerViewController.swift
//  WeatherApp
//
//  Created by Admin on 04.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation
import UIKit


class CityPickerViewController: UITableViewController, UISearchResultsUpdating  {
    
    var cities = [String]()
    
    var selectedCity:String? = nil
    var selectedCityIndex:Int? = nil
    
    var searchController = UISearchController()
    var filteredCities = [String]()
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCities = cities.filter { city in
            return city.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        cities = ["Moscow", "St. Petersburg", "Vladivostok", "Volgograd", "Voronezh", "Yekaterinburg", "Kaliningrad", "Kazan'", "Krasnodar", "Novosibirsk", "Omsk", "Rostov-na-Donu", "Samara", "Yaroslavl'", "Chelyabinsk"]
        if let city = selectedCity {
            if searchController.isActive && searchController.searchBar.text != "" {
                if filteredCities.contains(city) {
                    selectedCityIndex = filteredCities.index(of: city)!
                }
            } else {
                if cities.contains(city) {
                    selectedCityIndex = cities.index(of: city)!
                }
            }
            
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
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCities.count
        }
        return cities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        let city : String
        if searchController.isActive && searchController.searchBar.text != "" {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        cell.textLabel?.text = city
        
        
        if city == selectedCity {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedCity" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                selectedCityIndex = indexPath?.row
                
                if let index = selectedCityIndex {
                    if searchController.isActive && searchController.searchBar.text != "" {                        selectedCity = filteredCities[index]}
                    else
                    {
                        selectedCity = cities[index]
                    }
                }
            }
        }
        
        
    }
}
