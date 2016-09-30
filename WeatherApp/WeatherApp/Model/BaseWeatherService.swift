//
//  BaseWeatherService.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

enum SupportedServices {
    case Yahoo
}

class BaseWeatherService : WeatherServiceProtocol {
    
    static let session = URLSession(configuration: URLSessionConfiguration.default)
    
    class func weatherService(service : SupportedServices) -> BaseWeatherService {
        switch service {
        case .Yahoo:
            return YahooWeatherService()
        }
    }
    
    func retrieveWeatherInfo(locationName: String, completionHandler: (WeatherProtocol?, WeatherServiceError?) -> Void) {//Throws?
        guard let url = urlRequestUrlForLocation(withName: locationName) else {
            let error = WeatherServiceError(errorCode : .URLError)
            completionHandler(nil, error)
            return
        }
        let task = BaseWeatherService.session.dataTask(with: url) { (data, response, error) in
            
        }
        task.resume()
    }
    
    func urlRequestUrlForLocation(withName name : String) -> URL? {
        return nil
    }
    
    func parse(data: Data) -> WeatherProtocol? {
        return nil;
    }
    
}
