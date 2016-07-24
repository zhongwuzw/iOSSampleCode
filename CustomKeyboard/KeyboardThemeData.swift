//
//  KeyboardThemeData.swift
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/24.
//  Copyright © 2016年 钟武. All rights reserved.
//

import UIKit
import Foundation

let ThemePreference: String = "pref_theme"

let ButtonFontName = "Helvetica"
let ButtonFontSize: CGFloat = 16.0
let SpecialButtonFontSize: CGFloat = 12.0

class KeyboardThemeData: NSObject {
    
    var themeID: Int = 0
    var themeName: String = ""
    
    var colorForBackground: UIColor = UIColor.clearColor()
    var colorForCustomRow: UIColor = UIColor.clearColor()
    var colorForRow1: UIColor = UIColor.clearColor()
    var colorForRow2: UIColor = UIColor.clearColor()
    var colorForRow3: UIColor = UIColor.clearColor()
    var colorForRow4: UIColor = UIColor.clearColor()
    
    var colorForButtonFont: UIColor = UIColor.clearColor()
    
    var keyboardButtonFont: UIFont = UIFont(name: ButtonFontName, size: ButtonFontSize)!
    var buttonFontSize = 16
    var buttonSpecialFontSize = 12
    
    class func configureThemeData() -> [KeyboardThemeData] {
        let themeData = [KeyboardThemeData.solidTheme(),
                         KeyboardThemeData.fadeTheme(),
                         KeyboardThemeData.stripedTheme(),
                         KeyboardThemeData.noneTheme()]
        
        return themeData
    }
    
    class func solidTheme() -> KeyboardThemeData {
        
        let theme: KeyboardThemeData = KeyboardThemeData()
        theme.themeID = 0
        theme.themeName = "Solid"
        
        theme.colorForBackground = UIColor(red: 107.0/255.0, green: 205.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        
        theme.colorForCustomRow = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        theme.colorForRow1 = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        theme.colorForRow2 = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        theme.colorForRow3 = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        theme.colorForRow4 = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        
        theme.colorForButtonFont = UIColor.whiteColor()
        
        theme.keyboardButtonFont = UIFont(name: ButtonFontName, size: ButtonFontSize)!
        
        return theme
    }
    
    class func fadeTheme() -> KeyboardThemeData {
        
        let theme: KeyboardThemeData = KeyboardThemeData()
        theme.themeID = 1
        theme.themeName = "Fade"
        
        theme.colorForBackground = UIColor(red: 138.0/255, green: 212.0/255, blue: 177.0/255, alpha: 1.0)
        
        theme.colorForCustomRow = UIColor(red: 155.0/255, green: 217.0/255, blue: 187.0/255, alpha: 1.0)
        theme.colorForRow1 = UIColor(red: 138.0/255, green: 212.0/255, blue: 177.0/255, alpha: 1.0)
        theme.colorForRow2 = UIColor(red: 121.0/255, green: 208.0/255, blue: 166.0/255, alpha: 1.0)
        theme.colorForRow3 = UIColor(red: 103.0/255, green: 203.0/255, blue: 156.0/255, alpha: 1.0)
        theme.colorForRow4 = UIColor(red: 86.0/255, green: 198.0/255, blue: 146.0/255, alpha: 1.0)
        
        theme.colorForButtonFont = UIColor.whiteColor()
        
        theme.keyboardButtonFont = UIFont(name: ButtonFontName, size: ButtonFontSize)!
        
        return theme
    }
    
    class func stripedTheme() -> KeyboardThemeData {
        
        let theme: KeyboardThemeData = KeyboardThemeData()
        theme.themeID = 2
        theme.themeName = "Striped"
        
        theme.colorForBackground = UIColor(red: 122.0/255.0, green: 208.0/255, blue: 168.0/255, alpha: 1.0)
        
        theme.colorForCustomRow = UIColor(red: 103.0/255.0, green: 203.0/255, blue: 156.0/255, alpha: 1.0)
        theme.colorForRow1 = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        theme.colorForRow2 = UIColor(red: 103.0/255.0, green: 203.0/255, blue: 156.0/255, alpha: 1.0)
        theme.colorForRow3 = UIColor(red: 69.0/255.0, green: 195.0/255.0, blue: 136.0/255.0, alpha: 1.0)
        theme.colorForRow4 = UIColor(red: 103.0/255.0, green: 203.0/255, blue: 156.0/255, alpha: 1.0)
        
        theme.colorForButtonFont = UIColor.whiteColor()
        
        theme.keyboardButtonFont = UIFont(name: ButtonFontName, size: ButtonFontSize)!
        
        return theme
    }
    
    class func noneTheme() -> KeyboardThemeData {
        
        let theme: KeyboardThemeData = KeyboardThemeData()
        theme.themeID = 3
        theme.themeName = "None"
        
        theme.colorForBackground = UIColor(red: 239.0/255.0, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        
        theme.colorForCustomRow = UIColor(red: 239.0/255.0, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        theme.colorForRow1 = UIColor(red: 239.0/255.0, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        theme.colorForRow2 = UIColor(red: 239.0/255.0, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        theme.colorForRow3 = UIColor(red: 239.0/255.0, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        theme.colorForRow4 = UIColor(red: 239.0/255.0, green: 239.0/255, blue: 239.0/255, alpha: 1.0)
        
        theme.colorForButtonFont = UIColor(red: 80.0/255.0, green: 203.0/255, blue: 154.0/255, alpha: 1.0)
        
        theme.keyboardButtonFont = UIFont(name: ButtonFontName, size: ButtonFontSize)!
        
        return theme
    }

}
