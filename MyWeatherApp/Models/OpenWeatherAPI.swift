//
//  API.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation
import CoreLocation

struct OpenWeatherAPI {
    
    //MARK: - Properties
    
    //private static let personalApiKey = "8ea0ccc157ea9f8a73b722e89237d1c9"
    private static let apiKey = "273fab6e6c50fd8c332693983fa661a8"
    
    private static let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&units=imperial&appid=" //8ea0ccc157ea9f8a73b722e89237d1c9"
    
    // use default coordinates for Graniteville, SC, USA
    private(set) public var latitude = "33.542327880859375"
    private(set) public var longitude = "-81.84025986520047"
    
    private static var URL_LATITUDE = "&lat="
    private static var URL_LONGITUDE = "&lon="
    
    
    //MARK: - Instance Methods
    
    public mutating func setCoordinates(location: CLLocation) {
        latitude = String(location.coordinate.latitude)
        longitude = String(location.coordinate.longitude)
    }
    
    public func getURL() -> URL {
        return URL(string: OpenWeatherAPI.URL_BASE + OpenWeatherAPI.apiKey + OpenWeatherAPI.URL_LATITUDE + latitude + OpenWeatherAPI.URL_LONGITUDE + longitude)!
    }

    static func weather(fromJSON data: Data) -> Result<OneCallWeatherData, Error> {
        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(OneCallWeatherData.self, from: data)
            return .success(weatherResponse)
        } catch {
            return .failure(error)
        }
    }
}

