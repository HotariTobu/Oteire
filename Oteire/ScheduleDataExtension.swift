//
//  ScheduleDataExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

extension ScheduleData {
    private func requestNotification(trigger: UNNotificationTrigger) {
        removeNotification()
        
        let content = UNMutableNotificationContent()
        content.title = name
        content.subtitle = "Do It".localized
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateNotification() {
        let calender = Calendar.current
        let dateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        requestNotification(trigger: trigger)
    }
    
    func retainNotification() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        requestNotification(trigger: trigger)
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
}
