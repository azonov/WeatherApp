//
//  ForecastMO+CoreDataClass.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData


public class ForecastMO: NSManagedObject {
    
    func populate(json: Any) {
        guard let jsonDictionary = json as? [String : Any] else {
            return
        }
        guard let text = jsonDictionary["text"] as? String else {
            return;
        }
        self.text = text;
        guard let low = jsonDictionary["low"] as? String else {
            return;
        }
//        self.low = low;
//        guard let high = jsonDictionary["high"] as? String else {
//            return;
//        }
//        self.high = high;
//        guard let date = jsonDictionary["date"] as? String else {
//            return;
//        }
//        self.date = date;
    }
    
}
