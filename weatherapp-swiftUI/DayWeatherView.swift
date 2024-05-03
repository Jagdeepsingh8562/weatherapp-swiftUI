//
//  DayWeatherView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 03/05/24.
//

import SwiftUI

struct DayWeatherView: View {
    public var day: String
    public var temp: Int
    public var symbolName: String
    init(day: String = "TUE",temp: Int = 45,symbolName: String = "cloud.sun.fill") {
        self.day = day
        self.temp = temp
        self.symbolName = symbolName
    }
    var body: some View {
        VStack (spacing: 0){
            Text(day.uppercased())
                .font(.system(size: 15,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            Image(systemName: symbolName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("\(temp)°")
                .font(.system(size: 20,weight: .bold,design: .rounded))
                .foregroundColor(.white)
            Spacer()
        }
    }
}

#Preview {
    DayWeatherView()
}
