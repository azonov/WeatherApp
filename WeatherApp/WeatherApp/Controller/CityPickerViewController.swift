//
//  CityPickerViewController.swift
//  WeatherApp
//
//  Created by Admin on 04.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class CityPickerViewController: UITableViewController, CLLocationManagerDelegate , UISearchResultsUpdating{


    var cities:[String]!
    
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

    ///LESHCH
    var resultSearchController:UISearchController? = nil
    let locationManager = CLLocationManager()
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    ///LESHCH

    
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
        
        ///LESHCH
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        tableView.tableHeaderView = searchBar
        //searchBar.sizeToFit()
        //searchBar.placeholder = "Search with MKLocSearchReq"
        //navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        ///LESHCH
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNewCity(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New city",
                                      message: "Add a new city",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { (action: UIAlertAction!) -> Void in
                                        
                                        if (alert.textFields![0].text! != ""){
                                            let textField = alert.textFields![0]
                                            self.cities.append(textField.text!)
                                            self.tableView.reloadData()
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            cities.remove(at: indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.fade)
        }
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
    


    }}
