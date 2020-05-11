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
    
    @IBOutlet weak var forecastTypeSelector: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Properties
    
    // restrict number of hourly and daily forecasts
    let numberOfForecast = 5
    

    var weatherData: APIWeatherData?
    var weather: WeatherModel?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var countryCode: String?
    var stateOrProvince: String?
    var cityName: String?
    var timezone: String?
    
    var forecastType: ForecastType = .hourly
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the current date
        dateLabel.text = getCurrentDateAsString()
        
        // get current location
        getLocation()
        
        // set the tableview delegate
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
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            // try to minimize battery drain while still achieving accurate location monitoring
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.pausesLocationUpdatesAutomatically = true
        }
    }
    
    func getWeather() {
        NetworkService.shared.getWeather(onSuccess: { (weatherData) in
            self.weatherData = weatherData
            
            self.updateWeatherModel()
            
            self.updateCurrentWeather()
            
            self.tableView.reloadData()
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateWeatherModel() {
        guard weatherData != nil else { return }
        
        // set up current weather info
        let conditionId = weatherData!.current.weather[0].id
        let conditionImageName = getConditionImageName(conditionId)
        let conditionMain = weatherData!.current.weather[0].main
        let conditionDescription = weatherData!.current.weather[0].description
        let currentTemp = weatherData!.current.temp
        
        // set up hourly weather info
        var hourlyWeather = [HourlyWeatherModel]()
        for i in 1...5 {
            let time = Date(timeIntervalSince1970: TimeInterval(weatherData!.hourly[i].dt))
            let temp = weatherData!.hourly[i].temp
            let conditionId = weatherData!.hourly[i].weather[0].id
            let conditionImageName = getConditionImageName(conditionId)
            let hourly = HourlyWeatherModel(time: time, temp: temp, conditionId: conditionId, conditionImageName: conditionImageName)
            hourlyWeather.append(hourly)
        }
        
        // set up daily weather info
        var dailyWeather = [DailyWeatherModel]()
        for i in 1...5 {
            let date = Date(timeIntervalSince1970: TimeInterval(weatherData!.daily[i].dt))
            let minTemp = weatherData!.daily[i].temp.min
            let maxTemp = weatherData!.daily[i].temp.max
            let conditionId = weatherData!.daily[i].weather[0].id
            let conditionImageName = getConditionImageName(conditionId)
            let daily = DailyWeatherModel(date: date, minTemp: minTemp, maxTemp: maxTemp, conditionId: conditionId, conditionImageName: conditionImageName)
            dailyWeather.append(daily)
        }
        
        // set up the weather model
        weather = WeatherModel(currentTemp: currentTemp, conditionId: conditionId, conditionMain: conditionMain, conditionDescription: conditionDescription, conditionImageName: conditionImageName, hourlyWeather: hourlyWeather, dailyWeather: dailyWeather)
    }
    
    func updateCityView() {
        if let city = cityName {
            cityLabel.text = city
        }
    }
    
    func updateCurrentWeather() {
        
        if let weatherData = self.weatherData {
            let mainCondition = weatherData.current.weather[0].main
            let conditionDescription = weatherData.current.weather[0].description
            currentConditionDescription.text = mainCondition + " - " + conditionDescription
            
            let currentTemp = weatherData.current.temp
            currentTempLabel.text = String(format: "%.1f", currentTemp) + " F"
            
            let conditionImageName = getConditionImageName(weatherData.current.weather[0].id)
            currentConditionImageView.image = UIImage(systemName: conditionImageName)
        }
        
    }
    
    // determine which icon based on condition id
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
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(currentLocation!) { (placemarks, error) in
            if let error = error {
                debugPrint("Error finding city info: \(error.localizedDescription)")
            }
            // get the city from the location
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                if let city = placemark.locality {
                    self.cityName = city
                        
                    // update the city displayed in the app
                    self.updateCityView()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let validLocation = locations.first {
            //locationManager.stopUpdatingLocation()
            currentLocation = validLocation
            
            let latitude = Double(validLocation.coordinate.latitude)
            let longitude = Double(validLocation.coordinate.longitude)
            
            NetworkService.shared.setLatitude(fromDouble: latitude)
            NetworkService.shared.setLongitude(fromDouble: longitude)
            
            lookUpCurrentLocation()
            
            getWeather()
            
            updateWeatherModel()
        }
    }
}


//  MARK: - Table View DataSource Methods

extension WeatherVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch forecastType {
        case .hourly:
            guard weatherData?.hourly != nil else { return 0 }
        case .daily:
            guard weatherData?.daily != nil else { return 0 }
        }
        return numberOfForecast
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard weather != nil else { return ForecastTVC() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? ForecastTVC{
            
            switch forecastType {
            case .hourly:
                cell.updateView(hourlyForecast: weather!.hourlyWeather[indexPath.row])
                return cell
            case .daily:
                cell.updateView(dailyForecast: weather!.dailyWeather[indexPath.row])
                return cell
            }
            
        } else {
            return ForecastTVC()
        }
    }


}
