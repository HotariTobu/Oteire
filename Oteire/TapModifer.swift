//
//  TapModifer.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/24.
//

import SwiftUI

struct TapModifer: ViewModifier {
    let action: () -> Void
    
    @State private var isDragOver: Bool = false
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    let longPress = LongPressGesture(minimumDuration: 0)
                        .onEnded { _ in
                            isDragOver = true
                        }
                    let drag = DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .onChanged({ value in
                            isDragOver = proxy.frame(in: .global).contains(value.location)
                        })
                        .onEnded { _ in
                            if isDragOver {
                                isDragOver = false
                                action()
                            }
                        }
                    Color.clear
                        .contentShape(Rectangle())
                        .gesture(SimultaneousGesture(longPress, drag))
                }
            }
            .opacity(isDragOver ? 0.2 : 1)
            .animation(.easeInOut(duration: 0.1), value: isDragOver)
    }
}

