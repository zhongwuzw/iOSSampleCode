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
