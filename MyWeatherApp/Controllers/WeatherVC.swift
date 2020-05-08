//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/7/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    //MARK: - Properties
    
    var locationManager = CLLocationManager()
    
    var dateFormatter = DateFormatter()
    
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        if (CLLocationManager.locationServicesEnabled())
        {
            //locationManager = CLLocationManager()
            //locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            lookUpCurrentLocation { (place) in
                self.cityLabel.text = place?.locality
            }
        }
        
        dateFormatter.dateStyle = .full
        let currentDateString = dateFormatter.string(from: Date())
        dateLabel.text = currentDateString
        
    }
    
    //MARK: - Instance Methods
    
    
    
    //MARK: - IBActions
    
    
    
}

//MARK: - CLLocation Manager Delegate Methods

extension WeatherVC: CLLocationManagerDelegate {
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            let lat = "\(location.coordinate.latitude)"
            let long = "\(location.coordinate.longitude)"
        }
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}
