//
//  ScheduleListIOExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import Foundation

extension ScheduleList {
    private static let directoryURL: URL? = {
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = documentURL.appendingPathComponent("schedules")
            if !FileManager.default.fileExists(atPath: url.path) {
                do{
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            return url
        }
        return nil
    }()
    
    func load() {
        guard let directoryURL = ScheduleList.directoryURL else {
            return
        }
            
        var urls: [URL]?
        do {
            urls = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
        }
        catch {
            print(error.localizedDescription)
        }
        
        guard let urls = urls else {
            return
        }
        
        for url in urls {
            ScheduleData.load(at: url) { schedule in
                self.insertData(schedule)
            }
        }
    }
    
    func save() {
        guard let directoryURL = ScheduleList.directoryURL else {
            return
        }
        
        for schedule in changedList {
            schedule.updateNotification()
            
            let url = directoryURL.appendingPathComponent(schedule.id.uuidString)
            schedule.save(at: url)
        }
        changedList.removeAll()
        
        for schedule in removedList {
            schedule.removeNotification()
            
            do {
                let url = directoryURL.appendingPathComponent(schedule.id.uuidString)
                try FileManager.default.removeItem(at: url)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        removedList.removeAll()
    }
}
