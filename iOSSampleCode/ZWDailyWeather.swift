//
//  ZWDailyWeather.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation

let dayNameDateFormatter = DateFormatter()

class DailyWeather {
    fileprivate(set) var date: Date
    fileprivate(set) var status: WeatherStatus
    var dayName: String {
        dayNameDateFormatter.dateFormat = "E"
        return dayNameDateFormatter.string(from: date)
    }
    
    init(date: Date, status: WeatherStatus) {
        self.date = date
        self.status = status
    }
}
