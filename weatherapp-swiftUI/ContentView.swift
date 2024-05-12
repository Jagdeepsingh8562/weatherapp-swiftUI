//
//  ContentView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight: Bool = false
    @State private var weatherData : WeatherData?
    var body: some View {
        ZStack {
            BackgroudView(isDarkMode: $isNight)
            VStack{
                MainWeatherView(isDarkMode: isNight, weatherData: $weatherData).padding(.bottom,20)
                
                HStack(spacing: 10){
                    DayWeatherView(weatherModel: WeatherModel(weatherDaily: weatherData?.daily, postion: 1))
                    DayWeatherView(weatherModel: WeatherModel(weatherDaily: weatherData?.daily, postion: 2))
                    DayWeatherView(weatherModel: WeatherModel(weatherDaily: weatherData?.daily, postion: 3))
                    DayWeatherView(weatherModel: WeatherModel(weatherDaily: weatherData?.daily, postion: 4))
                    DayWeatherView(weatherModel: WeatherModel(weatherDaily: weatherData?.daily, postion: 5))
                    DayWeatherView(weatherModel: WeatherModel(weatherDaily: weatherData?.daily, postion: 6))
                }
                Spacer()
                ActionButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white, action: {
                    isNight.toggle()
                })
            }
        }.onAppear(perform: {
            fetchWeatherData()
        })
                
        
        
    }
    
    func fetchWeatherData()  {
        Task {
            self.weatherData = await WeatherRepo().fetchWeatherDataFromResponse()
            print(weatherData?.current.time ?? Date())
        }
    }
    
}

#Preview {
    ContentView()
}



struct BackgroudView: View {
    
   @Binding var isDarkMode: Bool
    var darkModeColors: [Color] = [.blue,.black]
    var lightModeColors: [Color] = [.blue,Color("LightBlueColor", bundle: nil)]
    
    var body: some View {
        LinearGradient(colors: isDarkMode ? darkModeColors : lightModeColors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}



struct ActionButton: View {
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
            
        }).frame(width: 280,height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20,weight: .bold,design: .monospaced))
            .clipShape(.buttonBorder)
            .padding(.bottom, 40)
    }
}
