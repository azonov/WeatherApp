//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UITableViewController, LocationDelegate, ProviderDelegate {
    
    
    var city: String?
    var locationManager: CustomLocationManager!
    var provider: WeatherProvider?
    
    var cityDescriptionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CustomLocationManager()
        locationManager.delegate = self
    }
   
    //MARK: ProviderDelegate
    func contentDidChange(withForecasts forecasts: [ForecastObjectProtocol]?) {
        self.tableView.reloadData()
    }
    //MARK: LocationDelegate
    func locationDidChange(city newCity: String?){
        city = newCity
        
        if self.navigationItem.title?.characters.last == ")"{
            
            let end = self.navigationItem.title?.index((self.navigationItem.title?.startIndex)!, offsetBy: cityDescriptionIndex)
            let temp = self.navigationItem.title?.substring(to: end!)
            self.navigationItem.title = temp! + " (" + city! + ")"
        }
        else {
            cityDescriptionIndex = (self.navigationItem.title?.characters.count)!
            self.navigationItem.title = self.navigationItem.title! + " (" + city! + ")"
        }
        
        provider = WeatherProvider.weatherProvider(forService: .Yahoo, location: city!)
        provider!.delegate = self
    }
    
    //MARK: UITableViewDataSourse
    override func numberOfSections(in tableView: UITableView) -> Int {
        if provider == nil{
            return 0
        }
        return provider!.numberOfObjects()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "ForecastCell")
        if let forecast = provider!.object(atIndex: indexPath.section) {
            cell.textLabel?.text = forecast.textString
            cell.detailTextLabel?.text = forecast.temperatureString
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return provider!.object(atIndex: section)?.dateString ?? ""
    }
}

