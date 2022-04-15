//
//  UIView + Extensions.swift
//  TrainApp1
//
//  Created by Ivan White on 11.04.2022.
//

import UIKit

///  Здесь мы будем расширять класс UIView

extension UIView {
    func addShadowOnView() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1
    }
}

/// Что тут происходит, тень можно создавать отдельно у каждой вью,
/// но что бы мы не копировали код 1000 раз,
/// сделаем это расширением, что бы сразу автоматом при объявлении экземпляра UIView,
/// у этого экземпляра была тень
