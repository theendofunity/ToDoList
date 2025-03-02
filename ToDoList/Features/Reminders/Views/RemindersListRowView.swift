//
//  RemindersListRowView.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct RemindersListRowView: View {
    @Binding var reminder: Reminder
    
    var body: some View {
        HStack {
            Toggle(isOn: $reminder.isCompleted, label: {})
                .toggleStyle(.reminder)
            
            Text(reminder.title)
        }
    }
}

#Preview {
    struct Container: View {
        @State var reminder = Reminder.samples[0]
        
        var body: some View {
            RemindersListRowView(reminder: $reminder)
        }
    }
    
    return Container()
}
