//
//  DailyTemp.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct DailyTemp: Codable {
    
    //MARK: - Properties
    
    let morn: Double // Morning temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit. How to change units format
    let day: Double // Day temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let eve: Double // Evening temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let night: Double // Night temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let min: Double //  Min daily temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let max: Double // Max daily temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.

}
