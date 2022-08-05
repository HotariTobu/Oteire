//
//  StringExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
