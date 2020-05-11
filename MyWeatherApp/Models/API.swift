//
//  API.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/8/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import Foundation

struct OpenWeatherAPI {
    let personalApiKey = "8ea0ccc157ea9f8a73b722e89237d1c9"
    let apiKey = "273fab6e6c50fd8c332693983fa661a8"
    
    let urlString = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely&appid=8ea0ccc157ea9f8a73b722e89237d1c9&lat=33.542327880859375&lon=-81.84025986520047"
}



//let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=33.563751&lon=-81.807892&exclude=minutely&appid=8ea0ccc157ea9f8a73b722e89237d1c9"

// call by city name, state, and country
//api.openweathermap.org/data/2.5/weather?q={city name},{state},{country code}&appid={your api key}

// call by city id
// api.openweathermap.org/data/2.5/weather?id={city id}&appid={your api key}
