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
    var conditionImageName: String
}
