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
    
    struct Attributes {
        static let date = "date"
        static let high = "high"
        static let low  = "low"
        static let text = "text"
    }
    
    struct Relationships {
        static let weather = "weather"
    }
    
    class func create(inContext context: NSManagedObjectContext) throws -> ForecastMO {
        let forecast = ForecastMO(context: context)
        return forecast
    }
    
}
