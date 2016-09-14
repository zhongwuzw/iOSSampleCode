//
//  ZWWeatherData.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation

class WeatherData {
    fileprivate(set) var cities = [CityWeather]()
    
    init(plistNamed:String){
        self.cities = loadWeatherData(plistNamed)
    }
    
    convenience init() {
        self.init(plistNamed: "WeatherData")
    }
    
    fileprivate func loadWeatherData(_ plistNamed:String) -> [CityWeather]{
        let plistRoot = NSDictionary(contentsOfFile: Bundle.main.path(forResource: plistNamed, ofType: "plist")!)
        var cityWeather = [CityWeather]()
        for (name, dailyWeather) in plistRoot as! [String : [NSDictionary]] {
            cityWeather.append(CityWeather(array: dailyWeather,name: name))
        }
        return cityWeather
    }

}

extension CityWeather {
    fileprivate convenience init(array: [NSDictionary], name: String) {
        var dailyWeather = [DailyWeather]()
        for dict in array {
            dailyWeather.append(DailyWeather(dictionary: dict))
        }
        self.init(name: name, weather: dailyWeather)
    }
}

extension DailyWeather {
    fileprivate convenience init(dictionary: NSDictionary) {
        let status = WeatherStatus(dictionary: dictionary)
        self.init(date: dictionary["date"] as! Date, status: status)
    }
}

extension WeatherStatus {
    fileprivate init(dictionary: NSDictionary) {
        let dictType = dictionary["type"] as! String
        self.init(temperature: dictionary["temperature"] as! Int, type: WeatherStatusType(rawValue: dictType)!)
    }
}

