//
//  ReminderToggleStyle.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct ReminderToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn
                  ? "largecircle.fill.circle"
                  : "circle")
            .imageScale(.large)
            .frame(width: 24, height: 24)
            .foregroundColor(configuration.isOn ? .accentColor : .gray)
            .onTapGesture {
                configuration.isOn.toggle()
            }
            configuration.label
        }
    }
}

extension ToggleStyle where Self == ReminderToggleStyle {
  static var reminder: ReminderToggleStyle {
    ReminderToggleStyle()
  }
}

#Preview {
    @Previewable @State var isOn = true
    
    return Toggle(isOn: $isOn) { Text("Hello") }
        .toggleStyle(.reminder)
}
