//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    let service = BaseWeatherService.weatherService(service: .Yahoo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.retrieveWeatherInfo(locationName: "Voronezh") { (result) in
            switch (result) {
            case .success(let weather):
                print("weather : \(weather)")
            case .failure(let error):
                print("error : \(error)")
            }
        }
    }
    
}

