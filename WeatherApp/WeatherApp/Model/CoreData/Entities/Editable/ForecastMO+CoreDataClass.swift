//
//  ForecastMO+CoreDataClass.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData


public class ForecastMO: NSManagedObject {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYY"
        return formatter
    }()
    
    class func create(fromJson json: Any, inContext context: NSManagedObjectContext) throws -> ForecastMO {
        let forecast = ForecastMO(context: context)
        try forecast.populate(json: json)
        return forecast;
    }
    
    func populate(json: Any) throws {
        guard let jsonDictionary = json as? [String : Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let text = jsonDictionary["text"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        self.text = text;
        guard let low = jsonDictionary["low"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let lowInt = Int16(low) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        self.low = lowInt;
        guard let high = jsonDictionary["high"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let highInt = Int16(high) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        self.high = highInt;
        guard let dateString = jsonDictionary["date"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let date = ForecastMO.formatter.date(from: dateString) else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        self.date = date as NSDate
    }
    
}
