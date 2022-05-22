//
//  Date + Extension.swift
//  TrainApp1
//
//  Created by Ivan White on 20.04.2022.
//

import Foundation
import UIKit
import RealmSwift

extension Date {
    
    func localDate()->Date {
        let timezoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        let localTime = Calendar.current.date(byAdding: .second, value: Int(timezoneOffset), to: self) ?? Date()
        return localTime
    }

    
    /// Добираемся к локальному времени телефона для того что бы занести в БД в локальном времени телефона
    
    
    func getWeekdayNumber()->Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self) /// из чего то выдираем день недели
        return weekday
    }
    
    
    
    func getWeekArray()->[[String]] {
        let timeZone = TimeZone(abbreviation: "UTC") ?? .current
        
        
        let formatter = DateFormatter() // делаем форматор что бы понедельник был пн итд
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = timeZone
        formatter.dateFormat = "EEEEEE"
        
        var weekArray : [[String]] = [[], []]
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekday = formatter.string(from: date)
            weekArray[0].append(weekday)
            // Сдвигаемся на -6 затем на число индекса дней
            // Далее добираемся до дня недели
            
        }
        return weekArray
    }
    
    func offsetDays(days:Int)->Date {
        let offsetDays = Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
        return offsetDays
    }
    
    func offsetMonth(month:Int)->Date {
        let offsetMonth = Calendar.current.date(byAdding: .month, value: -month, to: self) ?? Date()
        return offsetMonth
    }
    
    
    
    func starEndDate() -> (Date, Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let dateStart = formatter.date(from: "\(year)/\(month)/\(day)") ?? Date()
        
        let local = dateStart.localDate()
        let dateEnd: Date = {
            let components = DateComponents(day: 1)
            return calendar.date(byAdding: components, to: local) ?? Date()
        }()
        
        return (local, dateEnd)
    }
}
