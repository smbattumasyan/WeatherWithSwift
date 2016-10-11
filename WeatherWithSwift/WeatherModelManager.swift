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
    static let sharedInstance = BusinessLogic()

    //-------------------------------------------------------------------------------------------
    //MARK - Class Methods
    //-------------------------------------------------------------------------------------------

    func addWeather(currentWeather: CurrentWeather) {
        
        let weatherEntity = NSEntityDescription.entity(forEntityName: "CurrentWeather", in: fetchedResultsController.managedObjectContext)
        let weatherRecort = CurrentWeather(entity: weatherEntity!, insertInto: fetchedResultsController.managedObjectContext)

        weatherRecort.city        = currentWeather.city;
        weatherRecort.date        = currentWeather.date;
        weatherRecort.currentTemp = currentWeather.currentTemp;
        weatherRecort.main        = currentWeather.main
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

