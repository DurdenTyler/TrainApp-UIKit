//
//  UserModel.swift
//  TrainApp1
//
//  Created by Ivan White on 03.06.2022.
//

import Foundation
import RealmSwift


class UserModel: Object {
    @Persisted var userFirstName: String = "Unknown"
    @Persisted var userLastName: String = "Unknown"
    @Persisted var userHeight: Int = 0
    @Persisted var userWidth: Int = 0
    @Persisted var userTarget: Int = 0
    @Persisted var userImg:Data?
}
