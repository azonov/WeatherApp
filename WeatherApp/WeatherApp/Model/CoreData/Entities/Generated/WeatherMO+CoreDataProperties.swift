//
//  WeatherMO+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

extension WeatherMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherMO> {
        return NSFetchRequest<WeatherMO>(entityName: "Weather")
    }

    @NSManaged public var forecasts: NSSet?
    @NSManaged public var location: LocationMO?

}

// MARK: Generated accessors for forecasts
extension WeatherMO {

    @objc(addForecastsObject:)
    @NSManaged public func addToForecasts(_ value: ForecastMO)

    @objc(removeForecastsObject:)
    @NSManaged public func removeFromForecasts(_ value: ForecastMO)

    @objc(addForecasts:)
    @NSManaged public func addToForecasts(_ values: NSSet)

    @objc(removeForecasts:)
    @NSManaged public func removeFromForecasts(_ values: NSSet)

}
