//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct WeatherArrayData: Codable {
    var id: Int // Weather condition id
    var main: String // Group of weather parameters (Rain, Snow, Extreme etc.)
    var description: String // Weather condition within the group (full list of weather conditions). Get the output in your language
    var icon: String // Weather icon id.
}
