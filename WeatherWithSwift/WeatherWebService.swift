
//
//  WeatherWebService.swift
//  WeatherWithSwift
//
//  Created by Smbat Tumasyan on 9/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import UIKit

class WeatherWebService: NSObject {
}

extension WeatherWebService : WeatherService {
    func currentWeatherRequest(country: NSString, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        print(country);
        var request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(country)&units=metric&APPID=51e509f1096a2fb8e739ed1e51b4ac8c")!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
