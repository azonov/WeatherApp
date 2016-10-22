//
//  CoreDataProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

public struct WeatherCoreDataError: Error {
    enum Code: Int {
        case CreationError = -7000
        case ParsingError  = -7001
    }
    
    let errorCode: Code
}

protocol CoreDataProtocol {
    func save (context: NSManagedObjectContext) throws
    var persistentContainer: NSPersistentContainer  { get }
}
