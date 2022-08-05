//
//  DataEditView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

struct DataEditView: View {
    let data: ScheduleData
    
    var editAction: (() -> Void)?
    var markAction: (() -> Void)?
    
    var body: some View {
        ScheduleDataView(data: data)
            .onDataChange(perform: editAction)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Mark as Done") {
                        if let markAction = markAction {
                            markAction()
                        }
                    }
                }
            }
    }
}

struct DataEditView_Previews: PreviewProvider {
    static var previews: some View {
        DataEditView(data: ScheduleData())
    }
}
