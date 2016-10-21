//
//  ForecastMO+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

extension ForecastMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastMO> {
        return NSFetchRequest<ForecastMO>(entityName: "Forecast");
    }

    @NSManaged public var date: NSDate
    @NSManaged public var high: Int16
    @NSManaged public var low: Int16
    @NSManaged public var text: String
    @NSManaged public var weather: WeatherMO?

}
