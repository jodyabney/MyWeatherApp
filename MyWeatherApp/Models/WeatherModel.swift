//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/9/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    //MARK: - Properties
    
    var currentTemp: Double
    var conditionId: Int
    var conditionMain: String
    var conditionDescription: String
    var conditionImageName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "questionmark"
        }
    }
//    var hourlyWeather: [HourlyWeatherModel]
//    var dailyWeather: [DailyWeatherModel]
}
