//
//  SettingView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        Form {
            Section {
                Toggle("Retain Notifications", isOn: $settings.isRetainNotifications)
            } footer: {
                if settings.isRetainNotifications {
                    Text("Notify as long as Schedules have been not done or not clear the Notifications.")
                }
                else {
                    Text("Notify once when the Schedule date-time comes.")
                }
            }
            
            Text("If you have anything, please post it in the store.")
        }
        .onDisappear {
            settings.save()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
    }
}
