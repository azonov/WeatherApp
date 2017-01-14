//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class ForecastViewController: UITableViewController, ProviderDelegate {
    
    var city = "Voronezh"
    
    internal lazy var provider: WeatherProvider  = WeatherProvider.weatherProvider(forService: .Yahoo, location: self.city)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provider.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    //MARK: ProviderDelegate
    func contentDidChange(withForecasts forecasts: [ForecastObjectProtocol]?) {
        self.tableView.reloadData()
    }
    
    @IBAction func selectedCity(segue:UIStoryboardSegue) {
        if let cityPickerViewController = segue.source as? CityPickerViewController,
            let selectedCity = cityPickerViewController.selectedCity {
            city = selectedCity
            provider = WeatherProvider.weatherProvider(forService: .Yahoo, location: self.city)
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
        return provider.numberOfObjects()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = firstCell(indexPath: indexPath)
            return cell
        }
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "ForecastCell")
        if let forecast = provider.object(atIndex: indexPath.section) {
            cell.textLabel?.text = forecast.textString
            cell.detailTextLabel?.text = forecast.temperatureString
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return provider.object(atIndex: section)?.dateString ?? ""
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
        if let forecast = provider.object(atIndex: indexPath.section) {
            
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
            let forecast = provider.object(atIndex: tableView.indexPathForSelectedRow!.section)
            dayForecastVC.forecast = forecast
        }
    }
    
}

