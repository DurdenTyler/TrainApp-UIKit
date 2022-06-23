//
//  File.swift
//  TrainApp1
//
//  Created by Ivan White on 07.04.2022.
//

import UIKit

class WhatWeather:UIView{
    
    private let weatherLabel = UILabel(text: "Солнечно", fontName: "Roboto-Bold", fontSize: 23, textColor: .white, opacity: 1)
    
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
    
    private func updateWeather(model: WeatherModel) {
        weatherLabel.text = model.weather[0].myDescription + " \(model.main.temperatureCelsius)°C"
        
        switch model.weather[0].weatherDescription {
        case "clear sky": weatherLabel2.text = "Хорошая погода, что бы позаниматься на улице"
        case "few clouds": weatherLabel2.text = "На улице облачно"
        case "scattered clouds": weatherLabel2.text = "На улице облачно"
        case "broken clouds": weatherLabel2.text = "На улице облачно"
        case "shower rain": weatherLabel2.text = "На улице идет сильный дождь"
        case "rain": weatherLabel2.text = "Лучше быть дома, на улице дождь"
        case "thunderstorm": weatherLabel2.text = "Гроза"
        case "snow": weatherLabel2.text = "Идет снег"
        case "mist": weatherLabel2.text = "На улице туман"
        default: weatherLabel2.text = "No data"
        }
    }
    
    private func updateWeatherImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        weatherImage.image = image
    }
    
    public func setWeather(model: WeatherModel) {
        updateWeather(model: model)
    }
    
    public func setWeatherImage(data: Data) {
        updateWeatherImage(data: data)
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

// MARK: - setContrains
extension WhatWeather {
    private func setContrains() {
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            weatherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel2.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 6),
            weatherLabel2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13),
            weatherLabel2.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: weatherLabel2.trailingAnchor, constant: 15),
            weatherImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 75),
            weatherImage.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
