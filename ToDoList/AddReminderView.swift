//
//  AddReminderView.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct AddReminderView: View {
    @State private var reminder = Reminder(title: "")
    
    var onCommit: (_ reminder: Reminder) -> Void
    
    @Environment(\.dismiss)
    private var dismiss
    
    private func commit() {
        onCommit(reminder)
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        commit()
                    }
                }
            }
        }
    }
}

#Preview {
    AddReminderView { reminder in
        print("You added a new reminder titled \(reminder.title)")
    }
}
