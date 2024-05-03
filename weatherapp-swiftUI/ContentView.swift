//
//  ContentView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroudView(isDarkMode: false)
            VStack{
                CityTextView(cityName: "Jaipur, Raj")
                MainWeatherView().padding(.bottom,20)
                HStack(spacing: 10){
                    DayWeatherView(day: "TUE", symbolName: "cloud.rain.fill")
                    DayWeatherView(symbolName: "wind")
                    DayWeatherView()
                    DayWeatherView()
                    DayWeatherView()
                }
                Spacer()
                ActionButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
            }
        }
                
        
        
    }
}

#Preview {
    ContentView()
}

struct MainWeatherView: View {
    var body: some View {
        VStack (spacing: 0){
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180.0, height: 180.0)
            Text("43°")
                .font(.system(size: 70,weight: .bold,design: .rounded))
                .foregroundColor(.white)
        }
    }
}

struct BackgroudView: View {
    
    var isDarkMode: Bool
    
    var darkModeColors: [Color] = [.blue,.black]
    
    var lightModeColors: [Color] = [.blue,Color("LightBlueColor", bundle: nil)]
    
    var body: some View {
        LinearGradient(colors: isDarkMode ? darkModeColors : lightModeColors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
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

struct ActionButton: View {
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text(title)
            
        }).frame(width: 280,height: 50)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20,weight: .bold,design: .monospaced))
            .clipShape(.buttonBorder)
            .padding(.bottom, 40)
    }
}
