//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

class WeatherProvider : NSObject, ProviderProtocol, NSFetchedResultsControllerDelegate {

    class func weatherProvider(forService service : SupportedServices, location: String) -> WeatherProvider {
        switch service {
        case .Yahoo:
            return WeatherProvider(location: location,
                                   service: BaseWeatherService.weatherService(service: .Yahoo),
                                   coreData: CoreDataManager(),
                                   parser: BaseParser.parser(service: .Yahoo))
        }
    }
    
    func numberOfObjects() -> Int {
        return self.forecasts?.count ?? 0
    }
    func object(atIndex index: Int) -> ForecastObjectProtocol? {
        if let forecasts = self.forecasts , forecasts.count > index {
            return forecasts[index]
        }
        return nil
    }
    
    weak var delegate: ProviderDelegate?
    var forecasts: [ForecastObjectProtocol]? {
        get {
            return fetchResultsController?.fetchedObjects
        }
    }
    
    private let locationName: String
    private var fetchResultsController: NSFetchedResultsController<ForecastMO>?
    
    private var service: WeatherServiceProtocol
    private var coreData: CoreDataProtocol
    private var parser: ParserProtocol
    
    private init(location: String, service: WeatherServiceProtocol, coreData: CoreDataProtocol, parser: ParserProtocol) {
        self.locationName = location
        self.coreData = coreData
        self.service = service
        self.parser = parser
        super.init()
        let context = self.coreData.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ForecastMO>(entityName: "Forecast")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                            managedObjectContext: context,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: "Forecasts")
        fetchResultsController?.delegate = self
        do {
            try fetchResultsController?.performFetch()
        }catch {
            print(error)
        }
    }
    
    private func requestData()  {
        service.retrieveWeatherInfo(locationName: locationName) {[weak self](result) in
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
    
    private func parse(data: Data) throws -> LocationMO {
        let json = try JSONSerialization.jsonObject(with: data)
        let context = coreData.persistentContainer.viewContext
        let location = try LocationMO.createOrUpdate(forLocationWithName: self.locationName, inContext: context)
        try parser.populate(object: location, withJson: json)
        try coreData.save(context: context)
        return location
    }
    
    //MARK: NSFetchedResultsControllerDelegate
    internal func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.contentDidChange(withForecasts: self.forecasts)
    }
}

