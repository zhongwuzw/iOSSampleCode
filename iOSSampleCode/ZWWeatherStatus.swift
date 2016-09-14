//
//  File.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation
import UIKit

enum WeatherStatusType:String {
    case Sun = "sun"
    case Cloud = "cloud"
    case Lightning = "lightning"
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}

struct WeatherStatus {
    fileprivate(set) var temperature: Int
    fileprivate(set) var weatherType: WeatherStatusType
    
    init(temperature: Int, type: WeatherStatusType) {
        self.temperature = temperature
        self.weatherType = type
    }
}
