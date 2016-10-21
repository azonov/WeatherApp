//
//  YahooWeatherProvider.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import UIKit

class YahooWeatherProvider: WeatherProvider {
    override init(location: String) {
        super.init(location: location)
        self.service = BaseWeatherService.weatherService(service: .Yahoo)
        self.coreData = CoreDataManager()
        self.parser = BaseParser.parser(service: .Yahoo)
    }
}
