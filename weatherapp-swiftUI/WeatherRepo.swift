//
//  WeatherRepo.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 11/05/24.
//

import Foundation
import OpenMeteoSdk
import CoreLocation

class WeatherRepo {
    /// Make sure the URL contains `&format=flatbuffers`
    private var lat: Float
    private var lon: Float
    init(lat: Float = 26.9196, lon: Float = 75.7878) {
        self.lat = lat
        self.lon = lon
        self.url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current=temperature_2m,is_day,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=GMT&format=flatbuffers")!
        
    }
    private var url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=26.9196&longitude=75.7878&current=temperature_2m,is_day,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=GMT&format=flatbuffers")!
    
   private func fetchWeatherResponse() async ->  WeatherApiResponse?  {
        do {
            let response  = try await WeatherApiResponse.fetch(url: url)
            return response.first
        } catch let er {
            NSLog( "\(er)")
            return nil
        }
        
    }
    
   public func fetchWeatherDataFromResponse() async -> WeatherData? {
        
        let response = await fetchWeatherResponse()
        
        guard let response = response else { return nil }
        /// Attributes for timezone and location
        let utcOffsetSeconds = response.utcOffsetSeconds
        _ = response.timezone
        _ = response.timezoneAbbreviation
        let latitude = response.latitude
        let longitude = response.longitude

        let current = response.current!
        let daily = response.daily!
       
        
       let dailyWeatherCode : [WeatherCode] = {
           var codeList = [WeatherCode]()
           daily.variables(at: 0)!.values.forEach { code in
               codeList.append(getWeatherIcon(code: code))
           }
           return codeList
       }()
        
        let data = WeatherData(
            current: .init(
                time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                temperature2m: current.variables(at: 0)!.value,
                isDay: current.variables(at: 1)!.value,
                weatherCode: getWeatherIcon(code: current.variables(at: 2)!.value)
            ),
            daily: .init(
                time: daily.getDateTime(offset: utcOffsetSeconds),
                weatherCode: dailyWeatherCode,
                temperature2mMax: daily.variables(at: 1)!.values,
                temperature2mMin: daily.variables(at: 2)!.values
            )
        )
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
       
      
        
        
        for (i, date) in data.daily.time.enumerated() {
            print(dateFormatter.string(from: date))
            print(data.daily.weatherCode[i])
            print(data.daily.temperature2mMax[i])
            print(data.daily.temperature2mMin[i])
        }
        
        return data
    }
    
    public func getWeatherIcon(code: Float32) -> WeatherCode {
        switch code {
        case 0:
            return .clearSky(symbol: "sun.max.fill")
        case 1:
            return .mainlyClear(symbol: "cloud.sun.fill")
        case 2:
            return .partlyCloudy(symbol: "cloud.fill")
        case 3:
            return .overcast(symbol: "smoke.fill")
        case 45, 48:
            return .fog(symbol: "cloud.fog.fill")
        case 51:
            return .drizzleLight(symbol: "cloud.drizzle.fill")
        case 53:
            return .drizzleModerate(symbol: "cloud.drizzle")
        case 55:
            return .drizzleDense(symbol: "cloud.drizzle.fill")
        case 56:
            return .freezingDrizzleLight(symbol: "cloud.hail.fill")
        case 57:
            return .freezingDrizzleDense(symbol: "cloud.hail")
        case 61:
            return .rainSlight(symbol: "cloud.drizzle.fill")
        case 63:
            return .rainModerate(symbol: "cloud.rain.fill")
        case 65:
            return .rainHeavy(symbol: "cloud.heavyrain.fill")
        case 66:
            return .freezingRainLight(symbol: "cloud.sleet.fill")
        case 67:
            return .freezingRainHeavy(symbol: "cloud.sleet")
        case 71:
            return .snowfallSlight(symbol: "cloud.snow.fill")
        case 73:
            return .snowfallModerate(symbol: "cloud.snow")
        case 75:
            return .snowfallHeavy(symbol: "cloud.heavysnow.fill")
        case 77:
            return .snowGrains(symbol: "cloud.snow")
        case 80:
            return .rainShowersSlight(symbol: "cloud.sun.rain.fill")
        case 81:
            return .rainShowersModerate(symbol: "cloud.sun.rain")
        case 82:
            return .rainShowersViolent(symbol: "cloud.sun.rain.fill")
        case 85:
            return .snowShowersSlight(symbol: "cloud.sun.snow.fill")
        case 86:
            return .snowShowersHeavy(symbol: "cloud.sun.snow")
        case 95:
            return .thunderstormSlight(symbol: "cloud.bolt.rain.fill")
        case 96:
            return .thunderstormModerate(symbol: "cloud.bolt.rain")
        case 99:
            return .thunderstormHeavyHail(symbol: "cloud.bolt.hail.fill")
        default:
            return .clearSky(symbol: "sun.max.fill")
        }
    }
}
    
   
    

    
