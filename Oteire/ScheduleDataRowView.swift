//
//  ScheduleDataLabel.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/11.
//

import SwiftUI

struct ScheduleDataRowView: View {
    @ObservedObject var data: ScheduleData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.title)
                
                if !data.remarks.isEmpty {
                    Text(data.remarks)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            let calender = Calendar.current
            let components = calender.dateComponents([.month, .weekOfMonth, .day], from: .today, to: data.date)
            let isOver = data.date.compare(.now) == .orderedAscending
            
            if let month = components.month, month != 0 {
                ScheduleDataRowViewSubView(isOver: isOver, value: month, type: .monthly)
            }
            else if let week = components.weekOfMonth, week != 0 {
                ScheduleDataRowViewSubView(isOver: isOver, value: week, type: .weekly)
            }
            else if let day = components.day {
                ScheduleDataRowViewSubView(isOver: isOver, value: day, type: .daily)
            }
        }
    }
    
    private func getDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}

struct ScheduleDataRowViewSubView: View {
    let isOver: Bool
    let value: Int
    let type: IntervalType
    
    var body: some View {
        HStack(spacing: 5) {
            switch value {
            case -1:
                Text(type.last)
            case 0:
                Text(type.this)
            case 1:
                Text(type.next)
            default:
                Text((isOver ? -value : value).description)
                    .font(.title2)
                Group {
                    Text(type.unit)
                    if isOver {
                        Text("before")
                    }
                    else {
                        Text("after")
                    }
                }
                .font(.footnote)
            }
        }
        .foregroundColor(isOver ? .red : .blue)
    }
}

struct ScheduleDataRowView_Preview: PreviewProvider {
    static var previews: some View {
        let data = ScheduleData()
        data.name = "name"
        data.remarks = "remarks"
        data.remarks = "This is the remarks. I think this is very important to remember something"
        return ScheduleDataRowView(data: data)
    }
}
