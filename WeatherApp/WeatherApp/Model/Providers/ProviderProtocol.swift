//
//  ProviderProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

public struct ProviderError: Error {
    enum Code: Int {
        case CommonError = -8000
    }
    
    let errorCode: Code
}

protocol ForecastObjectProtocol {
    var dateString: String { get }
    var temperatureString: String { get }
    var textString: String { get }
    var averageTemperature: Int { get }
}

protocol ProviderProtocol {
    func numberOfObjects() -> Int
    func object(atIndex index: Int) -> ForecastObjectProtocol?
}

protocol ProviderDelegate: NSObjectProtocol {
    func contentDidChange(withForecasts forecasts: [ForecastObjectProtocol]?)
}
