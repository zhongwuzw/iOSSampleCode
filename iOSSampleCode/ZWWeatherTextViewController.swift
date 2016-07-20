//
//  ZWWeatherTextViewController.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/20.
//  Copyright © 2016年 钟武. All rights reserved.
//

import UIKit

protocol CityWeatherContainer {
    var cityWeather:CityWeather? {get set}
    
}

class ZWWeatherTextViewController: UIViewController,CityWeatherContainer {

    // MARK: - IBOutlets
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    // MARK: - Properties
    var cityWeather: CityWeather?{
        didSet{
            if isViewLoaded() {
                configureView()
            }
            provideDataToChildViewControllers()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Utility methods
    private func configureView() {
        if let cityWeather = cityWeather {
            cityNameLabel.text = cityWeather.name
            temperatureLabel.text = "\(cityWeather.weather[0].status.temperature)"
        }
    }
    
    private func provideDataToChildViewControllers(){
        for vc in childViewControllers {
            if var weeklyWeatherContainer = vc as? WeeklyWeatherContainer {
                if let weeklyWeather = cityWeather?.weather {
                    weeklyWeatherContainer.dailyWeather = weeklyWeather
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
