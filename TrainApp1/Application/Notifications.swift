//
//  Notifications.swift
//  TrainApp1
//
//  Created by Ivan White on 06.06.2022.
//

import UIKit
import UserNotifications

class Notifications: NSObject {
    
    // создаем экземпляр нотификатион центра
    let notificationCenter = UNUserNotificationCenter.current()
    
    // сперва нужно получить доступ на отправку уведомлений
    func requestAuthorization() {
        // вызываем алерт что бы появлялось само уведомление
        // далее мы хотим что бы был какой либо звук
        // а так же хотим что бы был бадж - это такой красный кружок на значке приложение - говорит об уведомлении
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    // метод с настройками
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { settings in
            print(settings)
        }
    }
    
    // пишем само уведомление, можем написать хоть сколько различных уведомлений
    // для того что бы создать уведомление нам нужно расписание
    // по факту мы создаем здесь само уведомление
    func scheduleDateNotifications(date: Date, id: String) {
        // Сперва мы создаем контент
        let content = UNMutableNotificationContent()
        content.title = "Здоровье и спорт"
        content.body = "На сегодня запланирована тренировка"
        content.sound = .default
        content.badge = 1
        
        // Далее нам нужно определить когда оно будет работать
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        // сейчас создаем условие когда должно срабатывать уведомление
        var triggerDate = calendar.dateComponents([.year, .month, .day], from: date)
        triggerDate.hour = 15
        triggerDate.minute = 09
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            if error != nil {
                print(error?.localizedDescription ?? "notification error")
            }
        }
    }
}

// Теперь нам нужно это всё немножечко обработать
extension Notifications: UNUserNotificationCenterDelegate {
    // Этот метод срабатывает когда экран приложения открыт
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    // Этот метод срабатывает когда мы нажимаем на само уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Убираем красный кругляш на приложении
        // Удаляем все уведомления что доставлены
        notificationCenter.removeAllDeliveredNotifications()
    }
}
