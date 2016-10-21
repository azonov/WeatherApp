//
//  WeatherMO+CoreDataClass.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData


public class WeatherMO: NSManagedObject {
    
    class func create(fromJson json: Any, inContext context: NSManagedObjectContext) throws -> WeatherMO {
        let weather = WeatherMO(context: context)
        try weather.populate(json: json, withContext: context)
        if context.hasChanges {
            try context.save()
        }
        return weather;
    }
    
    private func populate(json: Any, withContext context: NSManagedObjectContext) throws {
        guard let channel = json as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let item = channel["item"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let forecastsArray = item["forecast"] as? [[String : String]] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        var forecasts = [ForecastMO]()
        for forecastDictionary in forecastsArray {
            forecasts.append(try ForecastMO.create(fromJson: forecastDictionary, inContext: context))
        }
    }
}
