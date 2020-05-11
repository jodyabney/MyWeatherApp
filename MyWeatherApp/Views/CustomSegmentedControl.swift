//
//  CustomSegmentedControl.swift
//  TakeMyMoney
//
//  Created by Jody Abney on 5/6/20.
//  Copyright © 2020 AbneyAnalytics. All rights reserved.
//

import UIKit

@IBDesignable // make displayable in Interface Builder
class CustomSegmentedControl: UISegmentedControl {

    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView() {
        // set up the Payment Method Segmented Control Appearance
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Avenir", size: 14)?.bold()
        ]
        
        setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .selected)
        setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
}

// extend UIFont to set up for bold
extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

}
