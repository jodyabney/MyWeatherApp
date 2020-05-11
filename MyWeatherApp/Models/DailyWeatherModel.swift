//
//  DailyWeatherModel.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/10/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct DailyWeatherModel {
    var date: Date
    var minTemp: Double
    var maxTemp: Double
    var conditionId: Int
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
}
