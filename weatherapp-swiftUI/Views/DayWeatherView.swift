//
//  DayWeatherView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 03/05/24.
//

import SwiftUI
import Foundation
struct DayWeatherView: View {
    public var weatherModel: WeatherModel
    
    init(weatherModel: WeatherModel = WeatherModel()) {
        self.weatherModel = weatherModel
    }
    
    
    
    
    var body: some View {
        VStack (spacing: 0){
            Text(weatherModel.dayName.uppercased())
                .font(.system(size: 15,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            WeatherStatusImageView(weatherCode: weatherModel.weatherCode, imageSize: 40)
            Text("\(Int(weatherModel.temp))°c")
                .font(.system(size: 18,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            Spacer()
        }
    }
}

#Preview {
    DayWeatherView()
}
