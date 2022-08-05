//
//  IntervalType.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/18.
//

import SwiftUI

enum IntervalType: Int, CaseIterable, Codable {
    case daily
    case weekly
    case monthly
    
    var text: LocalizedStringKey {
        switch self {
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .monthly:
            return "Monthly"
        }
    }
    
    var unit: LocalizedStringKey {
        switch self {
        case .daily:
            return "days"
        case .weekly:
            return "weeks"
        case .monthly:
            return "months"
        }
    }
    
    var last: LocalizedStringKey {
        switch self {
        case .daily:
            return "Yesterday"
        case .weekly:
            return "Last Week"
        case .monthly:
            return "Last Month"
        }
    }
    
    var this: LocalizedStringKey {
        switch self {
        case .daily:
            return "Today"
        case .weekly:
            return "This Week"
        case .monthly:
            return "This Month"
        }
    }
    
    var next: LocalizedStringKey {
        switch self {
        case .daily:
            return "Tomorrow"
        case .weekly:
            return "Next Week"
        case .monthly:
            return "Next Month"
        }
    }
    
    var component: Calendar.Component {
        switch self {
        case .daily:
            return .day
        case .weekly:
            return.weekOfMonth
        case .monthly:
            return .month
        }
    }
}
