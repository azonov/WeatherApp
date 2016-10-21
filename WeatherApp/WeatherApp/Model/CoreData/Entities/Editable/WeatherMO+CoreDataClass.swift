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
    
    class func create(inContext context: NSManagedObjectContext) throws -> WeatherMO {
        let weather = WeatherMO(context: context)
        return weather
    }
}
