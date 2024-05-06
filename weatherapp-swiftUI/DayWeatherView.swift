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
//    public var day: String
//    public var temp: Int
//    public var symbolName: String
//    init(day: String = "TUE",temp: Int = 45,symbolName: String = "cloud.sun.fill") {
//        self.day = day
//        self.temp = temp
//        self.symbolName = symbolName
//    }
    init(weatherModel: WeatherModel = WeatherModel(dayofWeek: .monday, temp: 35, weatherSymbol: .sunny)) {
        self.weatherModel = weatherModel
    }
    var body: some View {
        VStack (spacing: 0){
            Text(weatherModel.dayofWeek.rawValue.uppercased())
                .font(.system(size: 15,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            Image(systemName: weatherModel.weatherSymbol.rawValue)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("\(weatherModel.temp)°")
                .font(.system(size: 20,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            Spacer()
        }
    }
}

#Preview {
    DayWeatherView()
}
