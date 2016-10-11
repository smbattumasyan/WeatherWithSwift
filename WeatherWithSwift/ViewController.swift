//
//  ViewController.swift
//  WeatherWithSwift
//
//  Created by Smbat Tumasyan on 8/19/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class ViewController: UIViewController {
    //MARK - Properties
    let weatherModelManager = WeatherModelManager()
    let businessLogc = BusinessLogic()
    var weatherService: WeatherWebService?

    //MARK - IBOutlets
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var mainStatusLabel: UILabel!

    //-------------------------------------------------------------------------------------------
    //MARK - Life Circle
    //-------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.saveCurrentWeather()
    }

    //-------------------------------------------------------------------------------------------
    //MARK - Private Methods
    //-------------------------------------------------------------------------------------------

    func saveCurrentWeather() {
        weatherService = WeatherWebService()
        weatherService?.currentWeatherRequest(country: "Yerevan", completionHandler: { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                print("cityName:\(json.value(forKey: "name") as! String?)")

                self.jsonStringWithPrettyPrint(dictionary: json)
                self.businessLogc.saveOrUpdateCurrentWeather(weatherDict: json)
                let result = self.weatherModelManager.fetchedResultsController.fetchedObjects as? [CurrentWeather]
                print("city_________:\(result?[0].city)")
                print("city_________:\(result?[0].date)")
                print("city_________:\(result?[0].currentTemp)")
                print("city_________:\(result?[0].main)")

                DispatchQueue.main.async {
                    self.countryLabel.text = result?[0].city
                    self.dateLabel.text = self.stringFromDate(date: (result?[0].date)!)
                    self.currentTempLabel.text = NSString(format: "%.2f",(result?[0].currentTemp)!) as String
                    self.mainStatusLabel.text = result?[0].main
                }

            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        })
    }

    func stringFromDate(date: NSDate) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date as Date)

    }

    func jsonStringWithPrettyPrint(dictionary: NSDictionary) {
        do {
            let data = try JSONSerialization.data(withJSONObject:dictionary, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            print("dataString:\(dataString)")

            // do other stuff on success

        } catch {
            print("JSON serialization failed:  \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

