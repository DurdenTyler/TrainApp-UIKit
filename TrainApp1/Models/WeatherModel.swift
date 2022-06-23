//
//  WeatherModel.swift
//  TrainApp1
//
//  Created by Ivan White on 08.06.2022.
//

import UIKit

// Подписываем под протокол Decodable потому что нам нужно будет её декодировать

struct WeatherModel: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    // нам приходят кельвины и мы переводи их в цельсии
    var temperatureCelsius: Int {
        Int(temp - 273.15)
    }
}


struct Weather: Decodable {
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
    
    var myDescription: String {
        switch weatherDescription {
        case "clear sky": return "Ясно"
        case "few clouds": return "Облачно"
        case "scattered clouds": return "Облачно"
        case "broken clouds": return "Облачно"
        case "shower rain": return "Сильный дождь"
        case "rain": return "Дождь"
        case "thunderstorm": return "Гроза"
        case "snow": return "Снег"
        case "mist": return "Туман"
        default: return "No data"
        }
    }
}
