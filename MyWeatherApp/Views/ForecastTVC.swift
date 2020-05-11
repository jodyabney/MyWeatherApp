//
//  ForecastTVC.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/10/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

class ForecastTVC: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var timeDateLabel: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    //MARK: - Instance Methods
    
    func updateView(hourlyForecast: HourlyWeatherModel) {
        
        let tf = DateFormatter()
        //tf.dateFormat = "HH"
        tf.timeStyle = .short
        let strDate = tf.string(from: hourlyForecast.time)
        
        timeDateLabel.text = strDate
        forecastImage.image = UIImage(systemName: hourlyForecast.conditionImageName)
        tempLabel.text = String(format: "%.1f", hourlyForecast.temp)
    }
    
    func updateView(dailyForecast: DailyWeatherModel) {
        
        let tf = DateFormatter()
        tf.dateStyle = .full
        let strDate = tf.string(from: dailyForecast.date)
        let dateParts = strDate.split(separator: ",")
        
        timeDateLabel.text = String(dateParts[0])
        forecastImage.image = UIImage(systemName: dailyForecast.conditionImageName)
        tempLabel.text = "High: \(String(format: "%.1f", dailyForecast.maxTemp))\nLow: \(String(format: "%.1f", dailyForecast.minTemp))"
    }
    
    

}
