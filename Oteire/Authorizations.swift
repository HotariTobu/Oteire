//
//  Authorization.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

class Authorizations {
    private let unDelegate = UNDelegate()
    
    init() {
        UNUserNotificationCenter.current().delegate = unDelegate
    }
    
    func requestUNAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
