//
//  OpenWeatherService.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 30/09/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

class YahooWeatherService: BaseWeatherService {
    
    override func urlRequestUrlForLocation(withName name : String) -> URL? {
        let requestString = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(name)\")"
        guard let encodedString = requestString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil;
        }
        let endpoint = "https://query.yahooapis.com/v1/public/yql?q=\(encodedString)&format=json"
        return URL(string: endpoint)
    }
    
    override func parse(data: Data) throws -> WeatherProtocol {
        let json = try JSONSerialization.jsonObject(with: data)
        if let weather = Weather(json: json) {
            return weather
        }else {
            throw WeatherServiceError(errorCode: .JSONParsingFailed)
        }
    }
}
