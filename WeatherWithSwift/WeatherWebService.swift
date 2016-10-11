
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

//extension WeatherWebService : WeatherService {
//    func currentWeatherRequest(country:NSString, completionHandler:(NSData, URLResponse, NSError ) -> Void) {
//        print(country);
//        var request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(country)&units=metric&APPID=51e509f1096a2fb8e739ed1e51b4ac8c")!)
//        request.httpMethod = "POST"
//
////        URLSession.shared.dataTask(with: request, {completionHandler in  print("Enterred the completionHandler")
////        }).resume()
//    }
//}



//- (void)currentWeatherRequest:(NSString *)country completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
//    NSURLSession *session          = [NSURLSession sharedSession];
//    NSString *urlString            = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&APPID=51e509f1096a2fb8e739ed1e51b4ac8c",country];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:completionHandler];
//    [dataTask resume];
//}
