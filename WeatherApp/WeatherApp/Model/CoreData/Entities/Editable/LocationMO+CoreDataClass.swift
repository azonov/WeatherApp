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
    
    class func createOrUpdate(forLocationWithName locationName: String, inContext context: NSManagedObjectContext) throws -> LocationMO {
        let request: NSFetchRequest<LocationMO> = LocationMO.fetchRequest()
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
        return location
    }
    
}
