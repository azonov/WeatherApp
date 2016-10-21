//
//  CoreDataProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

public struct WeatherCoreDataError: Error {
    enum Code: Int {
        case CreationError = -7000
        case ParsingError  = -7001
    }
    
    let errorCode: Code
}
