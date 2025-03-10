//
//  AddReminderView.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct EditReminderDetailsView: View {
    enum FocusableField: Hashable {
        case title
    }
    
    enum Mode {
        case add
        case edit
    }
    
    var mode: Mode = .add
    @State var reminder = Reminder(title: "")
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
                    .onSubmit {
                        commit()
                    }
            }
            .navigationTitle(mode == .add ? "New reminder" : "Details")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        cancel()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(mode == .add ? "Add" : "Done") {
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
    EditReminderDetailsView { reminder in
        print("You added a new reminder titled \(reminder.title)")
    }
}

#Preview {
    EditReminderDetailsView(mode: .edit) { reminder in
        print("You added a new reminder titled \(reminder.title)")
    }
}
