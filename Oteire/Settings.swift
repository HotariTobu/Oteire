//
//  Settings.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

class Settings: ObservableObject, Codable {
    @Published var isRetainNotifications: Bool
    
    let authorizations = Authorizations()
    
    init() {
        self.isRetainNotifications = false
    }
    
    enum CodingKeys: String, CodingKey {
        case isRetainNotifications
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isRetainNotifications = try container.decode(Bool.self, forKey: .isRetainNotifications)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isRetainNotifications, forKey: .isRetainNotifications)
    }
}
