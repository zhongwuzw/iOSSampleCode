//
//  ZWCityTableViewCell.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/19.
//  Copyright © 2016年 钟武. All rights reserved.
//

import UIKit

class ZWCityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityWeather:CityWeather?{
        didSet{
            configureCell()
        }
    }
    
    private func configureCell(){
        cityImageView.image = cityWeather?.cityImage
        cityNameLabel.text = cityWeather?.name
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
