//
//  OneCallAPIResponse.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

//Parameters of API response
struct OneCallWeatherData: Codable {

    //MARK: - Properties
    
    let lat: Double // Geographical coordinates of the location (latitude)
    let lon: Double // Geographical coordinates of the location (longitude)
    let timezone: String // Timezone name for the requested location
    let current: CurrentWeather // Current weather data API response
    let hourly: [HourlyWeather] // Hourly forecast weather data API response
    let daily: [DailyWeather] // Daily forecast weather data API response
    
}
