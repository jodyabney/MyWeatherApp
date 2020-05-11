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
    var conditionImageName: String
    var hourlyWeather: [HourlyWeatherModel]
    var dailyWeather: [DailyWeatherModel]
}
