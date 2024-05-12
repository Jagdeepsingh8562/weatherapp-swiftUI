//
//  WeatherModel.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 03/05/24.
//

import Foundation
import SwiftUI


struct WeatherModel {
    public var date: Date
    public var weatherCode: WeatherCode
    public var temp: Float
    public var dayName : String = "Mon"
    
    init(date: Date? = Date(), weatherCode: WeatherCode? = WeatherRepo().getWeatherIcon(code: 0), tempMin: Float? = 20, tempMax: Float? = 30) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
        
        
        self.date = date ?? Date()
        self.weatherCode = weatherCode ?? WeatherRepo().getWeatherIcon(code: 0)
        self.temp = (tempMin ?? 20) + (tempMax ?? 35) / 2
        self.dayName = dateFormatter.string(from: date ?? Date())
    }
    
    init(weatherDaily: WeatherData.Daily?, postion: Int) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
        
        
        self.date = weatherDaily?.time[postion] ?? Date()
        self.weatherCode = weatherDaily?.weatherCode[postion] ?? WeatherRepo().getWeatherIcon(code: 0)
        self.temp = (weatherDaily?.temperature2mMin[postion] ?? 20) + (weatherDaily?.temperature2mMax[postion] ?? 30) / 2
        self.dayName = dateFormatter.string(from: weatherDaily?.time[postion] ?? Date())
    }
    

}

enum WeatherCode {
    case clearSky(symbol: String)
    case mainlyClear(symbol: String)
    case partlyCloudy(symbol: String)
    case overcast(symbol: String)
    case fog(symbol: String)
    case drizzleLight(symbol: String)
    case drizzleModerate(symbol: String)
    case drizzleDense(symbol: String)
    case freezingDrizzleLight(symbol: String)
    case freezingDrizzleDense(symbol: String)
    case rainSlight(symbol: String)
    case rainModerate(symbol: String)
    case rainHeavy(symbol: String)
    case freezingRainLight(symbol: String)
    case freezingRainHeavy(symbol: String)
    case snowfallSlight(symbol: String)
    case snowfallModerate(symbol: String)
    case snowfallHeavy(symbol: String)
    case snowGrains(symbol: String)
    case rainShowersSlight(symbol: String)
    case rainShowersModerate(symbol: String)
    case rainShowersViolent(symbol: String)
    case snowShowersSlight(symbol: String)
    case snowShowersHeavy(symbol: String)
    case thunderstormSlight(symbol: String)
    case thunderstormModerate(symbol: String)
    case thunderstormHeavyHail(symbol: String)
    
    var symbol: Image {
        switch self {
        case .clearSky(let symbol),
                .mainlyClear(let symbol),
                .partlyCloudy(let symbol),
                .overcast(let symbol),
                .fog(let symbol),
                .drizzleLight(let symbol),
                .drizzleModerate(let symbol),
                .drizzleDense(let symbol),
                .freezingDrizzleLight(let symbol),
                .freezingDrizzleDense(let symbol),
                .rainSlight(let symbol),
                .rainModerate(let symbol),
                .rainHeavy(let symbol),
                .freezingRainLight(let symbol),
                .freezingRainHeavy(let symbol),
                .snowfallSlight(let symbol),
                .snowfallModerate(let symbol),
                .snowfallHeavy(let symbol),
                .snowGrains(let symbol),
                .rainShowersSlight(let symbol),
                .rainShowersModerate(let symbol),
                .rainShowersViolent(let symbol),
                .snowShowersSlight(let symbol),
                .snowShowersHeavy(let symbol),
                .thunderstormSlight(let symbol),
                .thunderstormModerate(let symbol),
                .thunderstormHeavyHail(let symbol):
            return Image(systemName: symbol)
        }
    }
}
