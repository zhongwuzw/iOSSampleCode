//
//  ZWDailyWeatherCollectionViewCell.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/20.
//  Copyright © 2016年 钟武. All rights reserved.
//

import UIKit

class ZWDailyWeatherCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayNameLabel: UILabel!
    
    // MARK: - Properties
    var dailyWeather:DailyWeather?{
        didSet{
            configureView()
        }
    }
    
    // MARK: - Utility methods
    private func configureView() {
        if let dailyWeather = dailyWeather {
            dayNameLabel.text = dailyWeather.dayName
            temperatureLabel.text = "\(dailyWeather.status.temperature)"
            weatherIconImageView.image = dailyWeather.status.weatherType.image
        }
    }
}
