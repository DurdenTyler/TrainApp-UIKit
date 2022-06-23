//
//  NetworkRequest.swift
//  TrainApp1
//
//  Created by Ivan White on 08.06.2022.
//

import UIKit

class NetworkRequest {
    
    static let shared = NetworkRequest()
    init() {}
    
    
    // Создаем метод что будет выполнять у нас запрос, то есть мы хотим получить какие либо данные от нашего апи
    // у резалта есть 2 состояния - success и failure
    func requestData(completion: @escaping (Result<Data, Error>) -> Void) {
        let key = "afe3acfc0c7eaa878da6bf88eb5a93d0"
        let latitude = 59.933880
        let longitude = 30.337239
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)"
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Далее в асинхронном режиме, мы проверяем что к нам пришло
            // Сразу проверяем на ошибку, потому что если есть ошибка дальнейшие действия бесполезны
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        // что бы наша сессия запустилась тут нужно указать .resume()
        .resume()
    }
}
