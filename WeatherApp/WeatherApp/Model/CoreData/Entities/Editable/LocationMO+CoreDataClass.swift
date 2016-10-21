//
//  LocationMO+CoreDataClass.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData


public class LocationMO: NSManagedObject {
    
    class func entityName() -> String {
        return "Location"
    }
    
    class func createOrUpdate(fromJson json: Any, inContext context: NSManagedObjectContext) throws -> LocationMO {
        let request = NSFetchRequest<LocationMO>(entityName: entityName())
        let locationName = try getLocationName(fromJson: json)
        request.predicate = NSPredicate(format: "name = %@", locationName)
        let location: LocationMO
        let results = try context.fetch(request)
        if results.count == 0 {
            location = LocationMO(context: context)
            location.name = locationName
        }else {
            if let result = results.first {
                location = result
            }else {
                throw WeatherCoreDataError(errorCode: .CreationError)
            }
        }
        location.weather = try WeatherMO.create(fromJson: getChannel(fromJson: json), inContext: context)
        return location;
    }
    
    class func getLocationName(fromJson json: Any) throws -> String {
        let channelJson = try getChannel(fromJson: json)
        guard let locationJson = channelJson["location"] as? [String: Any] else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        guard let city = locationJson["city"] as? String else {
            throw WeatherCoreDataError(errorCode: .ParsingError)
        }
        return city;
    }
    
    class func getChannel(fromJson json: Any) throws -> [String: Any] {
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
