//
//  ScheduleDataView.swift
//  Oteire
//
//  Created by HotariTobu on 2022/02/11.
//

import SwiftUI

struct ScheduleDataView: View {
    @ObservedObject var data: ScheduleData
    
    @FocusState private var focusState: FocusField?
    @State private var pickerState: FocusField?
    
    private enum FocusField: Hashable {
        case nameField
        case dateField
        case timeField
        case intervalField
        case remarksField
    }
    
    private var isDatePickerPresented: Bool {
        pickerState == .dateField
    }
    
    private var isTimePickerPresented: Bool {
        pickerState == .timeField
    }
    
    var body: some View {
        Form {
            Section {
                FormItemView(label: "Name") {
                    TextField("Name", text: $data.name)
                        .multilineTextAlignment(.trailing)
                        .focused($focusState, equals: .nameField)
                }
                
                FormItemView(label: "Date") {
                    Text(data.date.dateDescription("YYYYMMMd"))
                        .foregroundColor(isDatePickerPresented ? .accentColor : .none)
                }
                .contentShape(Rectangle())
                .onTap {
                    if pickerState == .dateField {
                        pickerState = nil
                    }
                    else {
                        pickerState = .dateField
                    }
                }
                
                FormItemView(label: "Time") {
                    Text(data.date.dateDescription("hhmma"))
                        .foregroundColor(isTimePickerPresented ? .accentColor : .none)
                }
                .contentShape(Rectangle())
                .onTap {
                    if pickerState == .timeField {
                        pickerState = nil
                    }
                    else {
                        pickerState = .timeField
                    }
                }
                
                Picker(selection: $data.intervalType, content: {
                    ForEach(IntervalType.allCases, id: \.self, content: { type in
                        Text(type.text).tag(type)
                    })
                }, label: {})
                    .pickerStyle(SegmentedPickerStyle())
                
                FormItemView(label: "Interval") {
                    HStack {
                        TextField("Interval", value: $data.intervalValue, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .focused($focusState, equals: .intervalField)
                            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                                            if let textField = obj.object as? UITextField {
                                                textField.selectAll(nil)
                                            }
                                        }
                        Text(data.intervalType.unit)
                            .foregroundColor(.gray)
                    }
                }
                
                VStack(spacing: 0) {
                    FormItemView(label: "Remarks") {
                        EmptyView()
                    }
                    TextEditor(text: $data.remarks)
                        .frame(minHeight: 100)
                        .focused($focusState, equals: .remarksField)
                }
            } footer: {
                VStack(alignment: .leading) {
                    Text("Notify in")
                    ForEach(notificationDates, id: \.self) { date in
                        Text(date.dateDescription("YYYYMMMMdhhmma"))
                    }
                    Text("...")
                }
            }
        }
        .overlay {
            VStack {
                Spacer()
                
                Group {
                    if isDatePickerPresented {
                        DatePicker("", selection: $data.date, displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                    }
                    
                    if isTimePickerPresented {
                        DatePicker("", selection: $data.date, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                    }
                }
                .background {
                    Color(UIColor.systemGray5)
                }
                .transition(.move(edge: .bottom))
                .animation(.default, value: isDatePickerPresented)
                .animation(.default, value: isTimePickerPresented)
            }
        }
        .onChange(of: focusState) { newValue in
            //print("focus \(newValue.debugDescription)")
            if newValue != nil {
                pickerState = nil
            }
        }
        .onChange(of: pickerState) { newValue in
            //print("picker \(newValue.debugDescription)")
            if newValue != nil {
                //focusState = nil
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        /*.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
            pickerState = nil
        }*/
    }
    
    func onDataChange(perform action: (() -> Void)? = nil) -> some View {
        var copy: ScheduleData? = nil
        return self
            .onAppear(perform: {
                copy = ScheduleData(self.data)
            })
            .onDisappear(perform: {
                if let action = action, let copy = copy {
                    if self.data != copy {
                        action()
                    }
                }
            })
    }
    
    private var notificationDates: [Date] {
        var result: [Date] = []
        
        var date = data.date
        let type = data.intervalType
        let value = data.intervalValue
        for _ in 0..<3 {
            result.append(date)
            date = date.getNextDate(type: type, value: value)
        }
        
        return result
    }
}

struct ScheduleDataView_Preview: PreviewProvider {
    static var previews: some View {
        ScheduleDataView(data: ScheduleData())
    }
}
