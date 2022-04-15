//
//  UserNameLabel.swift
//  TrainApp1
//
//  Created by Ivan White on 07.04.2022.
//

import UIKit


class UserNameLabel:UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = "Your Name"
        self.font = UIFont(name: "Roboto-Medium", size: 20)
        self.adjustsFontSizeToFitWidth = true
        self.textColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
    }
    
}
