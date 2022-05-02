//
//  WorkoutModel.swift
//  TrainApp1
//
//  Created by Ivan White on 20.04.2022.
//

import Foundation
import RealmSwift


class WorkoutModel: Object {
    @Persisted var workoutDate:Date
    @Persisted var workoutNumberOfDay:Int = 0
    @Persisted var workoutName:String = "Unknown"
    @Persisted var workoutRepeat:Bool = true
    @Persisted var workoutSets:Int = 0
    @Persisted var workoutReps:Int = 0
    @Persisted var workoutTimer:Int = 0
    @Persisted var workoutStatus:Bool = false
    @Persisted var workoutImg:Data?
}
