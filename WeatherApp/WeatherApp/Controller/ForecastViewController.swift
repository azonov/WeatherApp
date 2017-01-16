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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
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
    
    @IBAction func selectedCity(segue:UIStoryboardSegue) {
        if let cityPickerViewController = segue.source as? CityPickerViewController,
            let selectedCity = cityPickerViewController.selectedCity {
            locationDidChange(city: selectedCity)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickCity" {
            if let cityPickerViewController = segue.destination as? CityPickerViewController {
                cityPickerViewController.selectedCity = city
            }
        }
    }
    
    //MARK: UITableViewDataSourse
    override func numberOfSections(in tableView: UITableView) -> Int {
        if provider == nil{
            return 0
        }
        //+1 необъодимо для добавления еще одной (информационной) ячейки в таблицу
        return provider!.numberOfObjects() + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = firstCell(indexPath: indexPath)
            return cell
        }
        
        if indexPath[0] == (provider?.numberOfObjects())! {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "ForecastCell")
            cell.detailTextLabel?.text = self.city! + ". Powered by " + (provider?.ServiceName)!
            return cell
        }
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard!
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DAY_FORECAST_ID") as? DayForecastViewController else {
            fatalError("Something went wrong")
        }
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0 {
            return 110
        }
        return 45
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
    let firstCellIdentifier = "TodayCell"
    
    func firstCell(indexPath: IndexPath) -> TodayViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: firstCellIdentifier) as! TodayViewCell
        if let forecast = provider!.object(atIndex: indexPath.section) {
            
            cell.temperature.text = String(forecast.averageTemperature) + "℃"
            cell.tempDistinction.text = String(forecast.temperatureDistinction)
            cell.info.text = String(forecast.textString)
        }
        return cell
    }
}

extension ForecastViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let dayForecastVC = viewController as? DayForecastViewController {
            let forecast = provider!.object(atIndex: tableView.indexPathForSelectedRow!.section)
            dayForecastVC.forecast = forecast
        }
    }
    
}

