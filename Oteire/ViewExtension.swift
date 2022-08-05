//
//  ViewExtension.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/24.
//

import SwiftUI

extension View {
    @ViewBuilder func onTap(perform action: @escaping () -> Void) -> some View {
        self.modifier(TapModifer(action: action))
    }
}
