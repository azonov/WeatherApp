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
    
    func retrieveWeatherInfo(locationName: String, completionHandler: @escaping (Result<WeatherProtocol>) -> Void) {
        guard let url = urlRequestUrlForLocation(withName: locationName) else {
            let error = WeatherServiceError(errorCode : .URLError)
            completionHandler(Result.failure(error))
            return
        }
        let task = BaseWeatherService.session.dataTask(with: url) {[weak self] (data, response, error) in
            if let error = error {
                completionHandler(Result.failure(error))
                return
            }
            if let data = data {
                do {
                    guard let weather = try self?.parse(data: data) else { return }
                    completionHandler(Result.success(weather))
                } catch {
                    completionHandler(Result.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func urlRequestUrlForLocation(withName name : String) -> URL? {
        return nil
    }
    
    func parse(data: Data) throws -> WeatherProtocol {
        throw WeatherServiceError(errorCode: .JSONParsingFailed)
    }
    
}
