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
    case OpenWeatherMap
}

class BaseWeatherService : WeatherServiceProtocol {
    
    var serviceName: String = "unknown service"
    
    var ServiceName: String
        {
        get
        {
            return serviceName;
        }
    }
    
    static let session = URLSession(configuration: URLSessionConfiguration.default)
    
    class func weatherService(service : SupportedServices) -> BaseWeatherService {
        switch service {
        case .Yahoo:
            return YahooWeatherService()
        case .OpenWeatherMap:
            return OpenWeatherMapService()
        }
    }
    
    func retrieveWeatherInfo(locationName: String, completionHandler: @escaping (Result<Any>) -> Void) {
        guard let url = urlRequestUrlForLocation(withName: locationName) else {
            let error = WeatherServiceError(errorCode : .URLError)
            completionHandler(Result.failure(error))
            return
        }
        let task = BaseWeatherService.session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completionHandler(Result.failure(error))
                return
            }
            if let data = data {
                completionHandler(Result.success(data))
            }
        }
        task.resume()
    }
    
    func urlRequestUrlForLocation(withName name : String) -> URL? {
        return nil
    }
}
