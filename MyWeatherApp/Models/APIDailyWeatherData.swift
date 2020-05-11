//
//  DailyWeather.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct APIDailyWeatherData: Codable {
    
    //MARK: - Properties
    
    let dt: Int // Time of the forecasted data, unix, UTC
    let sunrise: Int // Sunrise time, unix, UTC
    let sunset: Int // Sunset time, unix, UTC
    let temp: APIDailyTempData
    let feels_like: APIDailyFeelsLikeData
    let pressure: Int // Atmospheric pressure on the sea level, hPa
    let humidity: Int // Humidity, %
    let dew_point: Double // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let wind_speed: Double // Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour. How to change units format
    let wind_deg: Int // Wind direction, degrees (meteorological)
    let clouds: Int // Cloudiness, %
    let uvi: Double // UV index
    let weather: [APIWeatherArrayData] //(more info Weather condition codes)

}
