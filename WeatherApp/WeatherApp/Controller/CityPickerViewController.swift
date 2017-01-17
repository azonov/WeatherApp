//
//  CityPickerViewController.swift
//  WeatherApp
//
//  Created by Admin on 04.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import UIKit
import MapKit

class CityPickerViewController: UITableViewController, CLLocationManagerDelegate {

    var cities:[String]!
    
    var selectedCity:String? = nil
    var selectedCityIndex:Int? = nil
    
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
        cities = ["Moscow", "St. Petersburg", "Vladivostok", "Volgograd", "Voronezh", "Yekaterinburg", "Kaliningrad", "Kazan'", "Krasnodar", "Novosibirsk", "Omsk", "Rostov-na-Donu", "Samara", "Yaroslavl'", "Chelyabinsk"]
        if let city = selectedCity {
            if cities.contains(city) {
                selectedCityIndex = cities.index(of: city)!
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
