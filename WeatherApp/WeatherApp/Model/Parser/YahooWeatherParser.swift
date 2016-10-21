//
//  YahooWeatherParser.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

class YahooWeatherParser : BaseParser {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYY"
        return formatter
    }()
    
    override func populate(object: LocationMO, withJson json:Any) throws {
        try super.populate(object: object, withJson: json)
        let channel = try self.retreiveChannel(fromJson: json)
        let city = try self.retreiveCityName(fromChanelJson: channel)
        object.name = city
        let forecastsJson = try self.retreiveForecasts(fromChanelJson: channel)
        var forecasts = [ForecastMO]()
        guard let context = object.managedObjectContext else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        for forecastJson in forecastsJson {
            let forecast = try ForecastMO.create(inContext: context)
            try populate(forecast: forecast, withJson: forecastJson)
            forecasts.append(forecast)
        }
        let weather = try WeatherMO.create(inContext: context)
        weather.forecasts = Set(forecasts) as NSSet?
        object.weather = weather
    }
    
    private func populate(forecast: ForecastMO, withJson json:Any) throws {
        guard let jsonDictionary = json as? [String : Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let text = jsonDictionary["text"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.text = text
        guard let low = jsonDictionary["low"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let lowInt = Int16(low) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.low = lowInt
        guard let high = jsonDictionary["high"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let highInt = Int16(high) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.high = highInt
        guard let dateString = jsonDictionary["date"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let date = YahooWeatherParser.formatter.date(from: dateString) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        forecast.date = date as NSDate
    }
    
    private func retreiveCityName(fromChanelJson json:[String: Any]) throws -> String {
        guard let locationJson = json["location"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let city = locationJson["city"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        return city
    }
    
    private func retreiveForecasts(fromChanelJson json:[String: Any]) throws -> [[String : String]] {
        guard let item = json["item"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let forecastsArray = item["forecast"] as? [[String : String]] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        return forecastsArray
    }
    
    private func retreiveChannel(fromJson json:Any) throws -> [String: Any] {
        guard let jsonDictionary = json as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let queryJson = jsonDictionary["query"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let resultsJson = queryJson["results"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let channelJson = resultsJson["channel"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        return channelJson
    }
    
}
