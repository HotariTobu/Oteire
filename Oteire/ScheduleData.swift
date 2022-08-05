//
//  ScheduleData.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/11.
//

import SwiftUI

class ScheduleData: ObservableObject, Identifiable, Equatable, Codable {
    static func == (lhs: ScheduleData, rhs: ScheduleData) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.date == rhs.date &&
        lhs.intervalType == rhs.intervalType &&
        lhs.intervalValue == rhs.intervalValue &&
        lhs.remarks == rhs.remarks
    }
    
    let id: UUID
    
    @Published var name: String
    @Published var date: Date
    @Published var intervalType: IntervalType
    @Published var intervalValue: Int
    @Published var remarks: String
    
    init(id: UUID, name: String, date: Date, intervalType: IntervalType, intervalValue: Int, remarks: String) {
        self.id = id
        self.name = name
        self.date = date
        self.intervalType = intervalType
        self.intervalValue = intervalValue
        self.remarks = remarks
    }
    
    init(_ other: ScheduleData) {
        self.id = other.id
        self.name = other.name
        self.date = other.date
        self.intervalType = other.intervalType
        self.intervalValue = other.intervalValue
        self.remarks = other.remarks
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.date = Date.today
        self.intervalType = .daily
        self.intervalValue = 1
        self.remarks = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case internalType
        case internalValue
        case remarks
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        intervalType = try container.decode(IntervalType.self, forKey: .internalType)
        intervalValue = try container.decode(Int.self, forKey: .internalValue)
        remarks = try container.decode(String.self, forKey: .remarks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(intervalType, forKey: .internalType)
        try container.encode(intervalValue, forKey: .internalValue)
        try container.encode(remarks, forKey: .remarks)
    }
}
