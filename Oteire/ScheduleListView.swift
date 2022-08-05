//
//  ScheduleListView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

struct ScheduleListView: View {
    @ObservedObject var schedules: ScheduleList
    
    var addAction: (() -> Void)?
    
    var body: some View {
        List {
            ForEach($schedules.list) { $item in
                NavigationLink(tag: item.id, selection: $schedules.selectedId) {
                    DataEditView(data: item) {
                        withAnimation {
                            schedules.reinsertData(item)
                        }
                    } markAction: {
                        schedules.applyNextDate(item)
                    }
                    .onDisappear {
                        if schedules.settings.isRetainNotifications, item.date.compare(.now) == .orderedAscending {
                            item.retainNotification()
                        }
                    }
                } label: {
                    ScheduleDataRowView(data: item)
                }
            }
            .onDelete { indexSet in
                schedules.removeData(atOffsets: indexSet)
            }
            Button {
                if let addAction = addAction {
                    addAction()
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Add Schedule")
                        .font(.title2)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(schedules: ScheduleList())
    }
}
