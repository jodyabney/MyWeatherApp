//
//  NetworkService.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct NetworkService {
    
    //MARK: - Singleton
    
    static var shared = NetworkService()
    
    //MARK: - Properties
    
    private let apiKey = "273fab6e6c50fd8c332693983fa661a8"
    
    private let URL_BASE = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&units=imperial&appid="
    
    // se Graniteville, SC, USA as a default location
    private(set) public var latitude = "33.54229142091232"
    private(set) public var longitude = "-81.84014801748354"
    
    private let session = URLSession(configuration: .default)
    
    //MARK: - Instance Methods
    
    public func getURL() -> String {
        let urlString = URL_BASE + apiKey + "&lat=" + latitude + "&lon=" + longitude
        print(urlString)
        return urlString
    }
    
    public mutating func setLatitude(fromDouble: Double) {
        latitude = String(fromDouble)
    }
    
    public mutating func setLongitude(fromDouble: Double) {
        longitude = String(fromDouble)
    }
    
    public func getWeather(onSuccess: @escaping (OneCallWeatherData) -> Void,
                    onError: @escaping (String) -> Void) {
        let url = URL(string: getURL())!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        // parse the successful result (OneCallWeatherData)
                        let weatherData = try JSONDecoder().decode(OneCallWeatherData.self, from: data)
                        // handle success
                        onSuccess(weatherData)
                    } else {
                        onError("The response was not 200; it was \(response.statusCode).")
                    }
                }
                catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
