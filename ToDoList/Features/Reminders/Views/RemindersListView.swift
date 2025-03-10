//
//  ContentView.swift
//  ToDoList
//
//  Created by ddudkin on 2.3.25..
//

import SwiftUI

struct RemindersListView: View {
    @State private var isAddReminderDialogPresented = false
    
    @StateObject private var viewModel = RemindersListViewModel()
    
    @State var editableReminder: Reminder?
    
    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }
    
    var body: some View {
        List($viewModel.reminders) { $reminder in
            RemindersListRowView(reminder: $reminder)
                .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                    Button(role: .destructive, action: {
                        viewModel.delete(reminder)
                    }) {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                })
                .onChange(of: reminder.isCompleted) { _, newValue in
                    viewModel.setCompleted(reminder, isCompleted: newValue)
                }
                .onTapGesture {
                    editableReminder = reminder
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: presentAddReminderView) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isAddReminderDialogPresented) {
            EditReminderDetailsView { reminder in
                viewModel.addReminder(reminder)
            }
        }
        .sheet(item: $editableReminder) { reminder in
            EditReminderDetailsView(mode: .edit, reminder: reminder) { reminder in
                viewModel.update(reminder: reminder)
            }
        }
        .tint(.purple)
    }
}

#Preview {
    RemindersListView()
}
