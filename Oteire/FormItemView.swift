//
//  FormItemView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/24.
//

import SwiftUI

struct FormItemView<Content>: View where Content: View {
    let label: LocalizedStringKey
    
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            content()
        }
    }
}

struct FormItemView_Previews: PreviewProvider {
    static var previews: some View {
        FormItemView(label: "label") {
            Text("content")
        }
    }
}
