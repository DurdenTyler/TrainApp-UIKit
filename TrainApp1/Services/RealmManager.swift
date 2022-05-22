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
    
    func deleteWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
}
    
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, seconds: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutTimer = seconds
        }
}
    
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {
        try! localRealm.write {
            model.workoutStatus = bool
        }
}
}
