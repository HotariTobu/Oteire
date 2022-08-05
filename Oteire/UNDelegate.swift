//
//  UNDelegate.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/23.
//

import SwiftUI

class UNDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.notification.request.identifier
        let url = URL(string:"hotari.oteire://?id=\(identifier)")
        if let url = url {
            UIApplication.shared.open(url)
        }
        
        completionHandler()
    }
}
