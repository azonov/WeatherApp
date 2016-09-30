//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let service = BaseWeatherService.weatherService(service: .Yahoo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.retrieveWeatherInfo(locationName: "Voronezh") { (weather, error) in
            
        }
    }

}

