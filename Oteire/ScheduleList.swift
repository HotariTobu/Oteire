//
//  ScheduleList.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/19.
//

import SwiftUI

class ScheduleList: ObservableObject {
    @Published var list: [ScheduleData]
    @Published var selectedId: UUID?
    
    var changedList: [ScheduleData]
    var removedList: [ScheduleData]
    
    let settings: Settings
    
    init() {
        self.list = []
        self.changedList = []
        self.removedList = []
        self.settings = Settings.load()
    }
    
    func insertData(_ data: ScheduleData) {
        let index = list.firstIndex(where: {
            data.date.compare($0.date) == .orderedAscending
        })
        if let index = index {
            list.insert(data, at: index)
        }
        else {
            list.append(data)
        }
        
        changedList.append(data)
    }
    
    func reinsertData(_ data: ScheduleData) {
        let index = list.firstIndex(of: data)
        if let index = index {
            list.remove(at: index)
        }
        
        insertData(data)
    }
    
    func applyNextDate(_ data: ScheduleData) {
        data.date = data.date.getNextDate(type: data.intervalType, value: data.intervalValue)
        changedList.append(data)
    }
    
    func removeData(atOffsets indexSet: IndexSet) {
        indexSet.forEach { index in
            removedList.append(list[index])
        }
        list.remove(atOffsets: indexSet)
    }
}
