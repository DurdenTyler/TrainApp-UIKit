//
//  File.swift
//  TrainApp1
//
//  Created by Ivan White on 07.04.2022.
//

import UIKit

class WhatWeather:UIView{
    
    private let weatherLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Солнечно"
        label.font = UIFont(name: "Roboto-Bold", size: 23)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private let weatherLabel2:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Хорошая погода, что бы позаниматься на улице"
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.9058824182, green: 0.9058824182, blue: 0.9058824182, alpha: 1)
        return label
    }()
    
    
    private let weatherImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .init(named: "Sun")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        self.layer.cornerRadius = 10
        self.addShadowOnView() /// расширение что добавляет тень которое мы написали сами
        self.addSubview(weatherLabel)
        self.addSubview(weatherLabel2)
        self.addSubview(weatherImage)
        
    }
    
}

extension WhatWeather {
    private func setContrains() {
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel2.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 6),
            weatherLabel2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            weatherLabel2.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            weatherImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            weatherImage.widthAnchor.constraint(equalToConstant: 55),
            weatherImage.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
