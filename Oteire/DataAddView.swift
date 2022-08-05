//
//  DataAddSheetView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/19.
//

import SwiftUI

struct DataAddView: View {
    var cancelAction: (() -> Void)?
    var confirmAction: ((ScheduleData) -> Void)?
    
    @State private var newData = ScheduleData()
    
    var body: some View {
        NavigationView {
            ScheduleDataView(data: newData)
                .navigationTitle("New Schedule")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction, content: {
                        Button("Cancel") {
                            if let action = cancelAction {
                                action()
                            }
                        }
                    })
                    ToolbarItem(placement: .confirmationAction, content: {
                        Button("Add") {
                            if let action = confirmAction {
                                action(newData)
                                newData = ScheduleData()
                            }
                        }
                    })
                })
        }
    }
}

struct DataAddView_Previews: PreviewProvider {
    static var previews: some View {
        DataAddView()
    }
}
