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
    
    class func createOrUpdate(withName name: String, inContext context: NSManagedObjectContext) throws -> LocationMO {
        let request = NSFetchRequest<LocationMO>(entityName: entityName())
        request.predicate = NSPredicate(format: "name = %@", name)
        let location: LocationMO
        let results = try context.fetch(request)
        if results.count == 0 {
            location = LocationMO(context: context)
            location.name = name
        }else {
            if let result = results.first {
                location = result
            }else {
                throw WeatherCoreDataError(errorCode: .CreationError)
            }
        }
        if context.hasChanges {
            try context.save()
        }
        return location;
    }
    
}
