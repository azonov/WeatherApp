//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

class WeatherProvider : ProviderProtocol {
    
    class func weatherProvider(forService service : SupportedServices, location: String) -> WeatherProvider {
        switch service {
        case .Yahoo:
            return YahooWeatherProvider(location: location)
        }
    }
    
    private let locationName: String
    var service: WeatherServiceProtocol?
    var coreData: CoreDataProtocol?
    var parser: ParserProtocol?
    
    init(location: String) {
        self.locationName = location
    }
    
    func requestData()  {
        service?.retrieveWeatherInfo(locationName: locationName) {[weak self](result) in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let data):
                    do {
                        if let data = data as? Data {
                            guard let _ = try self?.parse(data: data) else { return }
                        }
                    }catch {
                        
                    }
                case .failure(let error):
                    print("error : \(error)")
                }
            }
        }
    }
    
    func parse(data: Data) throws -> LocationMO {
        let json = try JSONSerialization.jsonObject(with: data)
        if let context = coreData?.persistentContainer.viewContext {
            let location = try LocationMO.createOrUpdate(forLocationWithName: self.locationName, inContext: context)
            try parser?.populate(object: location, withJson: json)
            return location
        }
        throw ProviderError(errorCode: .CommonError)
    }
}

