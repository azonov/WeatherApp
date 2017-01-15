//
//  BaseParser.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

class BaseParser : ParserProtocol {
    
    class func parser(service : SupportedServices) -> ParserProtocol {
        switch service {
        case .Yahoo:
            return YahooWeatherParser()
        case .OpenWeatherMap:
            return YahooWeatherParser() //there is no OpenWeatherMap parser yet
        }
        
    }
    
    func populate(object: LocationMO, withJson json:Any) throws {
        
    }
}
