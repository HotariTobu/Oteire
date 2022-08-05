//
//  DateExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/19.
//

import Foundation

extension Date {
    static let today: Self = {
        let calender = Calendar.current
        var now = Date.now
        let minutes = calender.component(.minute, from: now)
        let seconds = calender.component(.second, from: now)
        now = calender.date(byAdding: .minute, value: -minutes, to: now) ?? now
        now = calender.date(byAdding: .second, value: -seconds, to: now) ?? now
        return now
    }()
    
    func dateDescription(_ template: String = "MMMd") -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(template)
        return formatter.string(from: self)
    }
    
    func getNextDate(type: IntervalType, value: Int) -> Date {
        let calender = Calendar.current
        let component = type.component
        
        let newDate = calender.date(byAdding: component, value: value, to: self)
        if let newDate = newDate {
            return newDate
        }
        
        return self
    }
}
