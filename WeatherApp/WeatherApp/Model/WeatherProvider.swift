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
                            guard let weather = try self?.parse(data: data) else { return }
                            
                        }
                    }catch {
                        
                    }
                case .failure(let error):
                    print("error : \(error)")
                }
            }
        }
    }
    
    func parse(data: Data) throws -> WeatherProtocol {
        let json = try JSONSerialization.jsonObject(with: data)
        let context = coreData.persistentContainer.viewContext
        let request = NSFetchRequest<LocationMO>(entityName: "Location")
        request.predicate = NSPredicate(format: "name = %@", self.locationName)
        let location: LocationMO?
        do {
            let results = try context.fetch(request)
            if results.count == 0 {
                location = LocationMO(context: context)
                location?.name = self.locationName
            }else {
                location = results.first
            }
        }catch {
            print("\(error)")
        }
        coreData.saveContext()
        throw WeatherServiceError(errorCode: .JSONParsingFailed)
    }
}
