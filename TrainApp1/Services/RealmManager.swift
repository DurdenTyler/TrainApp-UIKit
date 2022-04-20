//
//  RealmManager.swift
//  TrainApp1
//
//  Created by Ivan White on 20.04.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private init() {}
    
    let localRealm = try! Realm()
    
    ///Пишем метод где будем сохранять модель тренировки
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
}
