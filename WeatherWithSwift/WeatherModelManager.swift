//
//  WeatherModelManager.swift
//  WeatherWithSwift
//
//  Created by Smbat Tumasyan on 8/19/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit
import CoreData

class WeatherModelManager: NSObject {
    //MARK - Properties
    let coreDataManager = CoreDataManager()

    //MARK - Class Methods

    func addWeather(dictionary: NSDictionary) {
        
        let weatherEntity = NSEntityDescription.entity(forEntityName: "CurrentWeather", in: fetchedResultsController.managedObjectContext)
        let weatherRecort = CurrentWeather(entity: weatherEntity!, insertInto: fetchedResultsController.managedObjectContext)

        weatherRecort.city = dictionary.value(forKey: "name") as! String?
        let timeInterval = dictionary.value(forKey: "dt") as! Double
        weatherRecort.date = Date(timeIntervalSince1970: timeInterval) as NSDate?
        weatherRecort.currentTemp = dictionary.value(forKeyPath: "main.temp") as! Float
        let weather = (dictionary.value(forKey: "weather") as! NSArray).firstObject as! NSDictionary
        weatherRecort.main = weather.value(forKey: "main") as? String

        coreDataManager.saveContext();
    }

    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {

        // Initialize Fetch Request
        let fetchRequest             = NSFetchRequest<NSFetchRequestResult>(entityName:"CurrentWeather")
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "city", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            abort()
        }
        
        return fetchedResultsController
    }()
}

