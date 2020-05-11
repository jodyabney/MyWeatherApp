//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/7/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit
import CoreLocation

enum ForecastType {
    case hourly
    case daily
}

class WeatherVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentConditionDescription: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentConditionImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Properties
    

    var weatherData: OneCallWeatherData?
    var weather: WeatherModel?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var countryCode: String?
    var stateOrProvince: String?
    var cityName: String?
    
    var forecastType: ForecastType = .hourly
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the current date
        dateLabel.text = getCurrentDateAsString()
        
        getLocation()
        
        // set up weather manager delegate
        //store.delegate = self
        
        tableView.dataSource = self
    }
    
    //MARK: - Instance Methods
    
    func getCurrentDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let currentDateString = dateFormatter.string(from: Date())
        return currentDateString
    }
    
    func getLocation() {
        // get current location
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func getWeather() {
        NetworkService.shared.getWeather(onSuccess: { (weatherData) in
            self.weatherData = weatherData
            
            self.updateCurrentWeather()
            
            self.tableView.reloadData()
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateCurrentWeather() {
        if let city = cityName {
            cityLabel.text = city
        }
        
        if let weatherData = self.weatherData {
            let mainCondition = weatherData.current.weather[0].main
            let conditionDescription = weatherData.current.weather[0].description
            currentConditionDescription.text = mainCondition + ": " + conditionDescription
            
            let currentTemp = weatherData.current.temp
            currentTempLabel.text = String(format: "%.1f", currentTemp)
            
            let conditionImageName = getConditionImageName(weatherData.current.weather[0].id)
            currentConditionImageView.image = UIImage(systemName: conditionImageName)
        }
        
    }
    
    func getConditionImageName(_ conditionId: Int) -> String {
        
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "questionmark"
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func forecastSelectorChanged(_ sender: UISegmentedControl) {
        
        switch forecastType {
        case .hourly:
            forecastType = .daily
            tableView.reloadData()
        case .daily:
            forecastType = .hourly
            tableView.reloadData()
        }
    }
    
}





//MARK: - CLLocation Manager Delegate Methods

extension WeatherVC: CLLocationManagerDelegate {
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Failed to get location: \(error.localizedDescription)")
    }
    
    func lookUpCurrentLocation() {
        // Use the last reported location.
        //        if let lastLocation = self.locationManager.location {
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(currentLocation!) { (placemarks, error) in
            if let error = error {
                debugPrint("Error finding city info: \(error.localizedDescription)")
            }
            
            if let placemarks = placemarks {
                if placemarks.count > 0 {
                    let placemark = placemarks[0]
                    if let city = placemark.locality {
                        self.cityName = city
                    }
                }
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let validLocation = locations.first {
            locationManager.stopUpdatingLocation()
            currentLocation = validLocation
            
            let latitude = Double(validLocation.coordinate.latitude)
            let longitude = Double(validLocation.coordinate.longitude)
            
            NetworkService.shared.setLatitude(fromDouble: latitude)
            NetworkService.shared.setLongitude(fromDouble: longitude)
            
            lookUpCurrentLocation()
            
            getWeather()
        }
    }
}

//            store.fetchWeatherData(location: location!,
//                                   onSuccess: { (weatherData) in
//                print("weather data was successful")
//
//                // current weather
//                let currentTemp = weatherData.current.temp
//                let conditionId = weatherData.current.weather[0].id
//                let conditionMain = weatherData.current.weather[0].main
//                let conditionDescription = weatherData.current.weather[0].description

//                // get hourly weather for 5-hours
//                var hourlyWeather = [HourlyWeatherModel]()
//                for i in 0...4 {
//                    let hourlyDate = Date(timeIntervalSince1970: weatherData.hourly[i].dt)
//                    let hourlyConditionid = weatherData.hourly[i].weather[0].id
//                    let hourlyTemp = weatherData.hourly[i].temp
//
//                    let hourForecast = HourlyWeatherModel(time: hourlyDate, temp: hourlyTemp, conditionId: hourlyConditionid)
//                    hourlyWeather.append(hourForecast)
//                }
//
//                // get daily weather for 5-days
//                var dailyWeather = [DailyWeatherModel]()
//                for i in 0...4 {
//                    let dailyDate = Date(timeIntervalSince1970: weatherData.daily[i].dt)
//                    let dailyConditionid = weatherData.daily[i].weather[0].id
//                    let dailyHighTemp = weatherData.daily[i].temp.max
//                    let dailyLowTemp = weatherData.daily[i].temp.min
//
//                    let dailyForecast = DailyWeatherModel(time: dailyDate, minTemp: dailyLowTemp, maxTemp: dailyHighTemp, conditionId: dailyConditionid)
//                    dailyWeather.append(dailyForecast)
//                }

//                self.weather = WeatherModel(currentTemp: currentTemp, conditionId: conditionId, conditionMain: conditionMain, conditionDescription: conditionDescription)//, hourlyWeather: hourlyWeather, dailyWeather: dailyWeather)
//
//                self.updateCurrentWeather()
//
//        }, onError: { (error) in
//            print("there was an error: \(error)")
//        })
//        }
//    }
//}


//  MARK: - Table View DataSource Methods
extension WeatherVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard weatherData != nil else { return 0 }
        return 5 // restrict to 5 forecast entries
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? ForecastTVC{
            switch forecastType {
            case .hourly:
                let forecastData = weatherData?.hourly[indexPath.row]
                let date = Date(timeIntervalSince1970: TimeInterval(forecastData!.dt))
                let hourlyForecast = HourlyWeatherModel(time: date, temp: forecastData!.temp, conditionId: (forecastData?.weather[0].id)!)
                cell.updateView(hourlyForecast: hourlyForecast)
                return cell
            case .daily:
                let forecastData = weatherData?.daily[indexPath.row]
                let date = Date(timeIntervalSince1970: TimeInterval(forecastData!.dt))
                let dailyForecast = DailyWeatherModel(date: date, minTemp: forecastData!.temp.min, maxTemp: forecastData!.temp.max, conditionId: forecastData!.weather[0].id)
                cell.updateView(dailyForecast: dailyForecast)
                return cell
            }
        } else {
            return ForecastTVC()
        }
    }


}


////MARK: - WeatherManager Delegate Methods
//extension WeatherVC: WeatherManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WeatherStore, weather: OneCallWeatherData) {
//        DispatchQueue.main.async {
//            self.currentTempLabel.text = String(format: "%.1f", weather.)
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//
//}
