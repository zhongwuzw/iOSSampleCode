//
//  TestViewController.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/18.
//  Copyright © 2016年 钟武. All rights reserved.
//

import Foundation
import UIKit

class ZWAdaptiveLayoutViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    // MARK: - Properties
    var cityWeather: CityWeather? {
        didSet {
            // Update the view.
            if isViewLoaded {
                configureView()
                provideDataToChildViewControllers()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        provideDataToChildViewControllers()
    }
    
    // MARK: - Utility methods
    fileprivate func configureView() {
        if let cityWeather = cityWeather {
            title = cityWeather.name
            weatherIconImageView.image = cityWeather.weather[0].status.weatherType.image
        }
    }
    
    fileprivate func provideDataToChildViewControllers() {
        for vc in childViewControllers {
            if var cityWeatherContainer = vc as? CityWeatherContainer {
                cityWeatherContainer.cityWeather = cityWeather
            }
        }
    }
}
