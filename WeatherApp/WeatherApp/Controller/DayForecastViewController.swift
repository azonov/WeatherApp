//
//  DayForecastViewController.swift
//  WeatherApp
//
//  Created by Andrey Volodin on 26.11.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

internal let TEMPERATURE_PLACEHOLDER = "Unknown1"

public class DayForecastViewController: UIViewController {
    @IBOutlet weak var temperatureLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        temperatureLabel.text = TEMPERATURE_PLACEHOLDER
    }
    
    var forecast: ForecastObjectProtocol? {
        didSet {
            guard let forecast = forecast else {
                temperatureLabel.text = TEMPERATURE_PLACEHOLDER
                temperatureLabel.textColor = .black
                return
            }
            temperatureLabel.text = forecast.temperatureString
            
            let weatherState = WeatherState.from(forecast.averageTemperature)
            temperatureLabel.textColor = weatherState.color
        }
    }
}
