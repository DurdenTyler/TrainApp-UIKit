//
//  UILabel + Extensions.swift
//  TrainApp1
//
//  Created by Ivan White on 15.04.2022.
//

import UIKit

extension UILabel {
    convenience init(text:String = "", fontName:String = "Roboto-Medium", fontSize:CGFloat = 17 , textColor:UIColor, opacity:Float) {
        self.init()
        
        self.text = text
        self.font = UIFont(name: fontName, size: fontSize)
        self.textColor = textColor
        self.layer.opacity = opacity
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
