//
//  BusinessLogic.swift
//  WeatherWithSwift
//
//  Created by Smbat Tumasyan on 10/11/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit

class BusinessLogic: NSObject {

    let weatherModelManager = WeatherModelManager()
    let coreDataManager = CoreDataManager()



    //-------------------------------------------------------------------------------------------
    //MARK - Class Methods
    //-------------------------------------------------------------------------------------------

    func saveOrUpdateCurrentWeather(weatherDict: NSDictionary) {

        let currentWeather = CurrentWeather(context: coreDataManager.persistentContainer.viewContext)
        currentWeather.city = weatherDict.value(forKey: "name") as? String
        currentWeather.date = self.dateFromTimeInterval(timeInterval: weatherDict.value(forKey: "dt") as! Double) as NSDate?
        currentWeather.currentTemp = weatherDict.value(forKeyPath: "main.temp") as! Float
        let weather = (weatherDict.value(forKey: "weather") as! NSArray).firstObject as! NSDictionary
        currentWeather.main = weather.value(forKey: "main") as? String
        weatherModelManager.addWeather(currentWeather: currentWeather)
    }

    func dateFromTimeInterval(timeInterval: TimeInterval) -> Date {

        return Date(timeIntervalSince1970: timeInterval)
    }
}
