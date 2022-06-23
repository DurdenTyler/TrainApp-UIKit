//
//  NetworkImageRequest.swift
//  TrainApp1
//
//  Created by Ivan White on 10.06.2022.
//

import UIKit

class NetworkImageRequest {
    
    static let shared = NetworkImageRequest()
    init() {}

    func requestData(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlString = "https://openweathermap.org/img/wn/\(id)@2x.png"
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
