//
//  WeatherService.swift
//  WeatherWithSwift
//
//  Created by Smbat Tumasyan on 9/1/16.
//  Copyright © 2016 EGS. All rights reserved.
//

import Foundation

protocol WeatherService{
    func currentWeatherRequest(country: NSString, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
