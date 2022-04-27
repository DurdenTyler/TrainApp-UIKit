//
//  SimpleAlert.swift
//  TrainApp1
//
//  Created by Ivan White on 25.04.2022.
//

import UIKit

extension UIViewController {
    func alertSimpleOK(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(buttonOK)
        present(alertController, animated: true)
    }
}












