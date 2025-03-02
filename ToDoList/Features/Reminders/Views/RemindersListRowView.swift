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
            Image(systemName: reminder.isCompleted
                  ? "largecircle.fill.circle"
                  : "circle")
            .imageScale(.large)
            .foregroundStyle(.blue)
            
            Text(reminder.title)
        }
        .onTapGesture {
            reminder.isCompleted.toggle()
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
