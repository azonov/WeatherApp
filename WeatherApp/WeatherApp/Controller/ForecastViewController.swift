//
//  ViewController.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class ForecastViewController: UITableViewController {
    
    let service = BaseWeatherService.weatherService(service: .Yahoo)
    
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var temperaturesRange: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func awakeFromNib() {}
    override func viewDidLoad() {
        super.viewDidLoad()
        service.retrieveWeatherInfo(locationName: "Voronezh") {[weak self] (result) in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let weather):
                    if let forecast = weather.forecasts.first {
                        self?.currentTemperature.text = forecast.text;
                        self?.temperaturesRange.text = "↑" + forecast.high + " ↓" + forecast.low;
                    }
                case .failure(let error):
                    print("error : \(error)")
                }
            }
        }
    }
    
}

