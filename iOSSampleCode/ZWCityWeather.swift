//
//  ZWCityWeather.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation
import UIKit

class CityWeather {
    fileprivate(set) var name: String
    fileprivate(set) var weather: [DailyWeather]
    var cityImage: UIImage {
        return UIImage(named: name)!
    }
    
    init(name: String, weather: [DailyWeather]) {
        self.name = name
        self.weather = weather
    }
}
