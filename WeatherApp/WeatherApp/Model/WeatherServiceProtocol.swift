//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

struct WeatherServiceError {
    enum Code: Int {
        case URLError                 = -6000
        case NetworkRequestFailed     = -6001
        case JSONSerializationFailed  = -6002
        case JSONParsingFailed        = -6003
    }
    
    let errorCode: Code
}

protocol ForecastProtocol {
    var time: String { get }
    var temperature: String { get }
}

protocol WeatherProtocol {
    var location : String { get }
    var forecasts : [ForecastProtocol] { get }
}

typealias WeatherCompletionHandler = (WeatherProtocol?, WeatherServiceError?) -> Void

protocol WeatherServiceProtocol {
    func retrieveWeatherInfo(locationName: String, completionHandler: WeatherCompletionHandler)
}
