//
//  SettingsExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/21.
//

import Foundation

extension Settings {
    private static let fileURL: URL? = {
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return documentURL.appendingPathComponent("settings")
        }
        return nil
    }()
    
    static func load() -> Settings {
        var result: Settings?
        
        if let fileURL = Settings.fileURL {
            Settings.load(at: fileURL) { settings in
                result = settings
            }
        }
        
        if let result = result {
            return result
        }
        
        return Settings()
    }
    
    func save() {
        guard let fileURL = Settings.fileURL else {
            return
        }
        
        self.save(at: fileURL)
    }
}
