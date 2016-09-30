//
//  Forecast.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

class Forecast : ForecastProtocol {
    
    var date: String
    var low: String
    var high: String
    var text: String
    
    init?(json: Any) {
        self.date = ""
        self.low = ""
        self.high = ""
        self.text = ""
        guard let jsonDictionary = json as? [String : Any] else {
            return
        }
        guard let text = jsonDictionary["text"] as? String else {
            return;
        }
        self.text = text;
        guard let low = jsonDictionary["low"] as? String else {
            return;
        }
        self.low = low;
        guard let high = jsonDictionary["high"] as? String else {
            return;
        }
        self.high = high;
        guard let date = jsonDictionary["date"] as? String else {
            return;
        }
        self.date = date;
    }
}
