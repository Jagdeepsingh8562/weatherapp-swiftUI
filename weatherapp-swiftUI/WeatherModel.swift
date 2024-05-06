//
//  WeatherModel.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 03/05/24.
//

import Foundation


struct WeatherModel {
    
    var dayofWeek : Locale.Weekday
    var temp: Int
    var weatherSymbol: WeatherSymbols
    
    
}


enum WeatherSymbols: String {
    case sunny = "sun.max.fill"
    case rainny = "cloud.rain.fill"
    case sunWithCloud = "cloud.sun.fill"
    case moon = "moon.stars.fill"
    case moonWithCloud = "cloud.moon.fill"
    
}
