//
//  CustomLocationManager.swift
//  WeatherApp
//
//  Created by xcode on 26.11.16.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreLocation
class CustomLocationManager:NSObject, CLLocationManagerDelegate {
    public var city = ""
    var locationManager:CLLocationManager
    
    weak var delegate: LocationDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locationArray = locations as NSArray
        let location = locationArray.lastObject as! CLLocation
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks![0]
                self.city = pm.locality!
                self.delegate?.locationDidChange(city: self.city)
                manager.stopUpdatingLocation()
            }
        })
    }
    
}
