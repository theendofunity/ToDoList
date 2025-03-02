//
//  AddReminderView.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct AddReminderView: View {
    enum FocusableField: Hashable {
        case title
    }
    
    @State private var reminder = Reminder(title: "")
    var onCommit: (_ reminder: Reminder) -> Void
    
    @Environment(\.dismiss)
    private var dismiss
    
    @FocusState private var focusedField: FocusableField?
    
    private func commit() {
        onCommit(reminder)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                    .focused($focusedField, equals: .title)
            }
            .navigationTitle("New reminder")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        cancel()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        commit()
                    }
                    .disabled(reminder.title.isEmpty)
                }
            }
        }
        .onAppear {
            focusedField = .title
        }
    }
}

#Preview {
    AddReminderView { reminder in
        print("You added a new reminder titled \(reminder.title)")
    }
}
