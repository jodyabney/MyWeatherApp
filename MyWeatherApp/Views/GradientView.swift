//
//  GradientView.swift
//  MyWeatherApp
//
//  Created by Jody Abney on 5/11/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customizeView()
    }
    
    func customizeView() {
        // set up gradient view
        self.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        let firstColor = #colorLiteral(red: 0.3653919101, green: 0.6034501791, blue: 0.8015822172, alpha: 1)
        let secondColor = #colorLiteral(red: 0.2180151045, green: 0.287881881, blue: 0.5509503484, alpha: 1)
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
    }

}
