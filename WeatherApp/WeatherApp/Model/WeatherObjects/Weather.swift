//
//  Weather.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

class Weather: WeatherProtocol {
    
    internal var forecasts: [ForecastProtocol]
    internal var location: String
    
    init?(json: Any) {
        self.forecasts = []
        self.location = ""
        guard let jsonDictionary = json as? [String: Any] else {
            return
        }
        guard let query = jsonDictionary["query"] as? [String: Any] else {
            return
        }
        guard let results = query["results"] as? [String: Any] else {
            return
        }
        guard let channel = results["channel"] as? [String: Any] else {
            return
        }
        guard let location = channel["location"] as? [String: Any] else {
            return
        }
        guard let city = location["city"] as? String else {
            return
        }
        self.location = city
        guard let item = channel["item"] as? [String: Any] else {
            return
        }
        guard let forecastsArray = item["forecast"] as? [[String : String]] else {
            return;
        }
        for forecastDictionary in forecastsArray {
            if let forecastObject = Forecast(json: forecastDictionary) {
                self.forecasts.append(forecastObject)
            }
        }
    }
}
