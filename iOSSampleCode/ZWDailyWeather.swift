//
//  ZWDailyWeather.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation

let dayNameDateFormatter = NSDateFormatter()

class DailyWeather {
    private(set) var date: NSDate
    private(set) var status: WeatherStatus
    var dayName: String {
        dayNameDateFormatter.dateFormat = "E"
        return dayNameDateFormatter.stringFromDate(date)
    }
    
    init(date: NSDate, status: WeatherStatus) {
        self.date = date
        self.status = status
    }
}
