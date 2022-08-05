//
//  CodableExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/21.
//

import Foundation

class CodableHelper {
    fileprivate static let decoder = JSONDecoder()
    fileprivate static let encoder = JSONEncoder()
}

extension Decodable {
    static func load(at url: URL, perform action: (Self) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            action(try CodableHelper.decoder.decode(Self.self, from: data))
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

extension Encodable {
    func save(at url: URL) {
        do {
            let data = try CodableHelper.encoder.encode(self)
            FileManager.default.createFile(atPath: url.path, contents: data)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
