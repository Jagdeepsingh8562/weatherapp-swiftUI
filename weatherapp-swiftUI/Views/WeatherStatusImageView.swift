//
//  WeatherStatusImageView.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 07/05/24.
//

import Foundation
import SwiftUI

struct WeatherStatusImageView: View {
    var weatherCode: WeatherCode
    public var imageSize: CGFloat = 180
    var body: some View {
        weatherCode.symbol
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSize, height:imageSize)

    }
}
