//
//  NetworkDataFetch.swift
//  TrainApp1
//
//  Created by Ivan White on 10.06.2022.
//

import UIKit
import RealmSwift

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init (){}
    
    // пишем метод у которого либо получится распарсить данные в эту модель либо нет
    func fetchWeather(response: @escaping (WeatherModel?, Error?) -> Void) {
        // Вызываем request что написали раннее
        NetworkRequest.shared.requestData { result in
            switch result {
                
            case .success(let data):
                do {
                    let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    response(weather, nil)
                } catch let jsonError {
                    print("Failed to decode json", jsonError)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}
 
