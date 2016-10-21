//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

class WeatherProvider {
    
    private let service = BaseWeatherService.weatherService(service: .Yahoo)
    private let coreData = CoreDataManager()
    private let locationName: String
    
    init(location: String) {
        self.locationName = location
        requestData()
    }
    
    func requestData()  {
        service.retrieveWeatherInfo(locationName: "Voronezh") {[weak self](result) in
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
        return try LocationMO.createOrUpdate(fromJson: json, inContext: coreData.persistentContainer.viewContext)
    }
}

