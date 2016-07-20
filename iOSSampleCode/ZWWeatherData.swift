//
//  ZWWeatherData.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation

class WeatherData {
    private(set) var cities = [CityWeather]()
    
    init(plistNamed:String){
        self.cities = loadWeatherData(plistNamed)
    }
    
    convenience init() {
        self.init(plistNamed: "WeatherData")
    }
    
    private func loadWeatherData(plistNamed:String) -> [CityWeather]{
        let plistRoot = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource(plistNamed, ofType: "plist")!)
        var cityWeather = [CityWeather]()
        for (name, dailyWeather) in plistRoot as! [String : [DailyWeather]] {
            cityWeather.append(CityWeather(name: name, weather: dailyWeather))
        }
        return cityWeather
    }

}

extension CityWeather {
    private convenience init(array: [NSDictionary], name: String) {
        var dailyWeather = [DailyWeather]()
        for dict in array {
            dailyWeather.append(DailyWeather(dictionary: dict))
        }
        self.init(name: name, weather: dailyWeather)
    }
}

extension DailyWeather {
    private convenience init(dictionary: NSDictionary) {
        let status = WeatherStatus(dictionary: dictionary)
        self.init(date: dictionary["date"] as! NSDate, status: status)
    }
}

extension WeatherStatus {
    private init(dictionary: NSDictionary) {
        let dictType = dictionary["type"] as! String
        self.init(temperature: dictionary["temperature"] as! Int, type: WeatherStatusType(rawValue: dictType)!)
    }
}

