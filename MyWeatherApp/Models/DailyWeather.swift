//
//  DailyWeather.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct DailyWeather: Codable {
    
    //MARK: - Properties
    
    let dt: Int // Time of the forecasted data, unix, UTC
    let sunrise: Int // Sunrise time, unix, UTC
    let sunset: Int // Sunset time, unix, UTC
    let temp: DailyTemp
    let feels_like: DailyFeelsLike
    let pressure: Int // Atmospheric pressure on the sea level, hPa
    let humidity: Int // Humidity, %
    let dew_point: Double // Atmospheric temperature (varying according to pressure and humidity) below which water droplets begin to condense and dew can form. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let wind_speed: Double // Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour. How to change units format
//    let wind_gust: Double // Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour. How to change units format
    let wind_deg: Int // Wind direction, degrees (meteorological)
    let clouds: Int // Cloudiness, %
    let uvi: Double // UV index
//    let visibility: Int // Average visibility, meters
//    let rain: Double? // Precipitation volume, mm
//    let snow: Double? // Snow volume, mm
    let weather: [Weather] //(more info Weather condition codes)

}