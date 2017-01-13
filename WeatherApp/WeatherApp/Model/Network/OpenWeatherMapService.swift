//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by Admin on 13.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation

class OpenWeatherMapService: BaseWeatherService {
    
    override func urlRequestUrlForLocation(withName name : String) -> URL? {
        let appid = "0282a88a0525d75619767d7d94482211"
        let request = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(name)&units=metric&appid=\(appid)"
        return URL(string: request)
    }
}
