//
//  Configuration.swift
//  WeatherApp
//
//  Created by xcode on 26.11.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation

class LocationAndMeasureConfiguration{

    private var location: String?
    private var units: Temperature?
    
    let keyForLocationDefaults = "locationKey"
    let keyForUnitsDefaults = "unitsKey"
    
    let defaults = UserDefaults.standard
    
    init(){
        
        location = defaults.string(forKey: keyForLocationDefaults)
        if let unitsBuf =  defaults.string(forKey: keyForUnitsDefaults) {
            units = Temperature(rawValue: unitsBuf)
        } else {
            units = Temperature.fahrenheit
        }

    }
    
    public func UpdateValues(newPlace: String, newMeasure: String){
        location = newPlace
        if newMeasure == "℃" {
            units = Temperature.celsius
        }
        else if newMeasure == "℉" {
            units = Temperature.fahrenheit
        }
    }
    
    public func getLocation() -> String{
        if location != nil {
            return location!
        }
        else{
            return ""
        }
    }
    
    public func getMeasure() -> String{
        if units != nil {
            return units!.rawValue
        }
        else{
            return ""
        }
    }
    
    public func SaveChanges(){
        defaults.set(location, forKey: keyForLocationDefaults)
        defaults.set(units?.rawValue, forKey: keyForUnitsDefaults)
        defaults.synchronize()
    }
    
}
