//
//  MainWeatherView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 07/05/24.
//

import Foundation
import SwiftUI

struct MainWeatherView: View {
    var isDarkMode: Bool
    @Binding var weatherData : WeatherData?
    
    var body: some View {
        VStack (spacing: 0){
            CityTextView(cityName: weatherData?.cityName ?? "Jaipur")
            Spacer(minLength: 10)
            WeatherStatusImageView(weatherCode: weatherData?.current.weatherCode ?? WeatherRepo().getWeatherIcon(code: 1), imageSize: 180)
            Text("\(Int(weatherData?.current.temperature2m ?? 45))°c")
                .font(.system(size: 70,weight: .bold,design: .rounded))
                .foregroundColor(.white)
        }
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32,weight: .medium,design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

