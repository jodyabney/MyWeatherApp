//
//  CurrentWeather.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    
    //MARK: - Properties
    
    let dt: Int // Current time, unix, UTC
    let sunrise: Int // Sunrise time, unix, UTC
    let sunset: Int // Sunset time, unix, UTC
    let temp: Double // Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit. How to change units format
    let feels_like: Double // Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let pressure: Int // Atmospheric pressure on the sea level, hPa
    let humidity: Int // Humidity, %
    let dew_point: Double // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let uvi: Double // UV index
    let clouds: Int // Cloudiness, %
//    let visibility: Int // Average visibility, meters
    let wind_speed: Double // Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour. How to change units format
//    let wind_gust: Double? // Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour. How to change units format
    let wind_deg: Int // Wind direction, degrees (meteorological)
//    let rain: Double? // Precipitation volume, mm
//    let snow: Double? // Snow volume, mm
    let weather: [Weather] //  (more info Weather condition codes)
}
