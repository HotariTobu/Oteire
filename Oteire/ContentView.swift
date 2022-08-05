//
//  ContentView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/11.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var schedules = ScheduleList()
    
    @State private var isAddSheetPresented = false
    
    var body: some View {
        NavigationView {
            ScheduleListView(schedules: schedules, addAction: {
                isAddSheetPresented.toggle()
            })
                .navigationTitle(Date.today.dateDescription())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            isAddSheetPresented.toggle()
                        }, label: {
                            Image(systemName: "plus")
                        })
                    })
            }
        }
        .sheet(isPresented: $isAddSheetPresented) {
            DataAddView(cancelAction: {
                isAddSheetPresented.toggle()
            }, confirmAction: { newData in
                schedules.insertData(newData)
                isAddSheetPresented.toggle()
                
                schedules.settings.authorizations.requestUNAuthorization()
            })
        }
        .onAppear {
            schedules.load()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                schedules.save()
            }
        }
        .onOpenURL(perform: { url in
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            guard let components = components else {
                return
            }
            
            let uuidString = components.queryItems?.first(where: { urlQueryItem in
                urlQueryItem.name == "id"
            })?.value
            
            guard let uuidString = uuidString else {
                return
            }
            
            let id = UUID(uuidString: uuidString)
            schedules.selectedId = id
        })
        .environmentObject(schedules.settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
