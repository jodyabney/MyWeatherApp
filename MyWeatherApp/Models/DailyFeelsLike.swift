//
//  DailyFeelsLike.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct DailyFeelsLike: Codable {
    
    //MARK: - Properties
    
    let morn: Double // Morning temperature.Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit. How to change units format
    let day: Double // Day temperature.Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let eve: Double // Evening temperature.Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let night: Double // Night temperature.Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
}
