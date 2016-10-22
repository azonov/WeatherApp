//
//  ForecastMO+ForecastObjectProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 22/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

extension ForecastMO: ForecastObjectProtocol {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYY"
        return formatter
    }()
    
    var dateString: String {
        get {
            return ForecastMO.formatter.string(from: self.date as Date)
        }
    }
    
    var temperatureString: String {
        get {
            return String((high + low) / 2)
        }
    }
    var textString: String {
        get {
            return text
        }
    }
    
}
