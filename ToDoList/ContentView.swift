//
//  ContentView.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct ContentView: View {
    @State private var reminders = Reminder.samples
    
    var body: some View {
        List($reminders) { $reminder in
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
}

#Preview {
    ContentView()
}
