//
//  ContentView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 02/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight: Bool = false
    @State private var weatherData : CurrentWeatherResponseModel?
    var body: some View {
        ZStack {
            BackgroudView(isDarkMode: $isNight)
            VStack{
                CityTextView(cityName: weatherData?.name ?? "bn")
                MainWeatherView(isDarkMode: isNight, weatherData: $weatherData).padding(.bottom,20)
                HStack(spacing: 10){
                    DayWeatherView(weatherModel: WeatherModel(dayofWeek: .monday, temp: Int(weatherData?.main.temp ?? 45), weatherSymbol: .rainny))
                    DayWeatherView(weatherModel: WeatherModel(dayofWeek: .tuesday, temp: 45, weatherSymbol: .sunWithCloud))
                    DayWeatherView()
                    DayWeatherView()
                    DayWeatherView()
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
    
    func fetchWeatherData() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=26.79913416938583&lon=75.84860364496515&units=metric&appid=91d2fd40b897f21572fa1c6c9335fbb1")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                            let decodedData = try JSONDecoder().decode(CurrentWeatherResponseModel.self, from: data)
                            DispatchQueue.main.async {
                                self.weatherData = decodedData
                            }
                        } catch {
                            print(error)
                        }
        }.resume()
    }
}

#Preview {
    ContentView()
}

struct MainWeatherView: View {
    var isDarkMode: Bool
    @Binding var weatherData : CurrentWeatherResponseModel?
    var body: some View {
        VStack (spacing: 0){
            Image(systemName:isDarkMode ? "cloud.moon.fill" : "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180.0, height: 180.0)
            Text("\(Int(weatherData?.main.temp ?? 45))°")
                .font(.system(size: 70,weight: .bold,design: .rounded))
                .foregroundColor(.white)
        }
    }
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
