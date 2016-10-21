//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class ForecastViewController: UITableViewController {
    
    private lazy var provider = WeatherProvider.weatherProvider(forService: .Yahoo, location: "Voronezh")
    
}

