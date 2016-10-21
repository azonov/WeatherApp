//
//  ProviderProtocol.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

public struct ProviderError: Error {
    enum Code: Int {
        case CommonError = -8000
    }
    
    let errorCode: Code
}
