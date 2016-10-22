//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Andrey Zonov on 21/10/2016.
//  Copyright © 2016 VSU. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager : CoreDataProtocol {
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         Persistent Container для приложения. Реализация
         создает и возвращает контейнер. Свойство является optional, для 
         обработки ошибок при создании контейнера.
         */
        let container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func save (context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
