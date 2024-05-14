//
//  WeatherResponseModel.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 06/05/24.
import Foundation

struct WeatherData {
    let current: Current
    let daily: Daily

    struct Current {
        let time: Date
        let temperature2m: Float
        let isDay: Float
        let weatherCode: WeatherCode
    }
    struct Daily {
        let time: [Date]
        let weatherCode: [WeatherCode]
        let temperature2mMax: [Float]
        let temperature2mMin: [Float]
    }
}


//   let reverseGeocodingResponse = try? JSONDecoder().decode(ReverseGeocodingResponse.self, from: jsonData)

// MARK: - ReverseGeocodingResponseElement
struct ReverseGeocodingResponseElement: Codable {
    let name: String
    let lat, lon: Double
    let country, state: String
}

typealias ReverseGeocodingResponse = [ReverseGeocodingResponseElement]
