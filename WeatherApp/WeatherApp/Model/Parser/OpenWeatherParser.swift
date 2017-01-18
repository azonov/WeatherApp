//
//  OpenWeatherParser.swift
//  WeatherApp
//
//  Created by Михаил Нечаев on 18.01.17.
//  Copyright © 2017 VSU. All rights reserved.
//

import Foundation

class OpenWeatherParser : BaseParser {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYY"
        return formatter
    }()
    //
    override func populate(object: LocationMO, withJson json:Any) throws {
        try super.populate(object: object, withJson: json)
        let city = try self.retreiveCityName(fromJson: json as! [String : Any])
        object.name = city
        let list = try self.retreiveList(fromJson: json as! [String : Any])
        var forecasts = [ForecastMO]()
        guard let context = object.managedObjectContext else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        for item in list {
            let forecast = try ForecastMO.create(inContext: context)
            try populate(forecast: forecast, withJson: item)
            forecasts.append(forecast)
        }
        let weather = try WeatherMO.create(inContext: context)
        weather.forecasts = Set(forecasts) as NSSet?
        object.weather = weather
    }
    
    private func populate(forecast: ForecastMO, withJson item: Any) throws {
        guard let jsonDictionary = item as? [String : Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let dateString = jsonDictionary["dt"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let date = OpenWeatherParser.formatter.date(from: dateString) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.date = date as NSDate
        guard let weather = jsonDictionary["weather"] as? [String : Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let description = weather["description"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.text = description
        guard let low = jsonDictionary["min"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let lowInt = Int16(low) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.low = lowInt
        guard let high = jsonDictionary["max"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let highInt = Int16(high) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.high = highInt
    }
    //
    private func retreiveCityName(fromJson json:[String: Any]) throws -> String {
        guard let city = json["city"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let name = city["name"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        return name
    }
    //
    private func retreiveList(fromJson json:[String: Any]) throws -> [String : Any] {
        
        
        guard let list = json["list"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        return list
    }
}
